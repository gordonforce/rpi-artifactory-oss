FROM gordonff/rpi-tomcat:latest

MAINTAINER Gordon Force <gordonff@gmail.com>

# To update, check https://bintray.com/jfrog/artifactory/artifactory/view
ENV ARTIFACTORY_VERSION 4.14.3
ENV ARTIFACTORY_SHA1 2DDB93230F997C028ED0A6E74ADB064E6A67613A

# Disable Tomcat's manager application.
RUN rm -rf webapps/*

# Redirect URL from / to artifactory/ using UrlRewriteFilter
COPY urlrewrite/WEB-INF/lib/urlrewritefilter.jar /
COPY urlrewrite/WEB-INF/urlrewrite.xml /
RUN \
  mkdir -p webapps/ROOT/WEB-INF/lib && \
  mv /urlrewritefilter.jar webapps/ROOT/WEB-INF/lib && \
  mv /urlrewrite.xml webapps/ROOT/WEB-INF/

# Fetch and install Artifactory OSS war archive.
RUN \
  echo $ARTIFACTORY_SHA1 artifactory.zip > artifactory.zip.sha1 && \
  curl -Lk -o artifactory.zip https://bintray.com/artifact/download/jfrog/artifactory/jfrog-artifactory-oss-${ARTIFACTORY_VERSION}.zip && \
  sha1sum -c artifactory.zip.sha1 && \
  /usr/bin/unzip -j artifactory.zip "artifactory-*/webapps/artifactory.war" -d webapps && \
  rm artifactory.zip

# Expose tomcat runtime options through the RUNTIME_OPTS environment variable.
#   Example to set the JVM's max heap size to 256MB use the flag
#   '-e RUNTIME_OPTS="-Xmx256m"' when starting a container.
RUN echo 'export CATALINA_OPTS="$RUNTIME_OPTS"' > bin/setenv.sh

# Artifactory home
RUN mkdir -p /artifactory
ENV ARTIFACTORY_HOME /artifactory

# Expose Artifactories data, log and backup directory.
VOLUME /artifactory/data
VOLUME /artifactory/logs
VOLUME /artifactory/backup

WORKDIR /artifactory
