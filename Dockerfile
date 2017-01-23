FROM cpollet/rpi-jre8

LABEL maintianer "gordonff@gmail.com"

# To update, check https://bintray.com/jfrog/artifactory/artifactory/view
ENV AF_VERSION=4.16.0 \
		AF_SHA1=CFF2C0ECF8F535CD092CA51614FE7577C7213CBB \
		AF_HOME=/artifactory
ENV	AF_BASE=artifactory-oss-${AF_VERSION} 
ENV	AF_DL_FILE=artifactory.zip \
		AF_URL=https://bintray.com/artifact/download/jfrog/artifactory/jfrog-${AF_BASE}.zip

# Download and extract an artifactory version into the /artifactory directory
# Alter the JVM configuration to use a heap maximum of 512m instead of 2g
RUN apt-get update -yqq \
	&& apt-get install -yqq curl unzip \
	&& mkdir ${AF_HOME} \
	&& cd ${AF_HOME} \
  && echo ${AF_SHA1} artifactory.zip  > artifactory.zip.sha1 \
  && curl -Lk -o ${AF_DL_FILE} ${AF_URL} \
  && sha1sum -c artifactory.zip.sha1 \
  && unzip -o ${AF_DL_FILE} \
  && mv ${AF_BASE}/* . \
  && rm -rf ${AF_DL_FILE} ${AF_BASE} \
  && cd bin \
  && sed -ri 's/2g/512m/g' artifactory.default

VOLUME ${AF_HOME}/data
VOLUME ${AF_HOME}/logs
VOLUME ${AF_HOME}/backup

EXPOSE 8081

WORKDIR ${AF_HOME}

CMD bin/artifactory.sh
