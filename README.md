## Artifactory

Run [Artifactory](http://www.jfrog.com/home/v_artifactory_opensource_overview) inside a Docker container.

Ported from the artificatory image provided by [Matt Gruter](https://registry.hub.docker.com/u/mattgruter/artifactory/).

### Volumes
Artifactories `data`, `logs` and `backup` directories are exported as volumes:

    /artifactory/data
    /artifactory/logs
    /artifactory/backup

### Ports
The web server is accessible through port `8080`.

### Example

In the Raspberry Pi terminal enter:

    docker run -p 8080:8080 gordonff/rpi-artifactory-oss

Now point an RPI web-browser at http://localhost:8080 to see the Artifactory home page.

### URLs
The artifactory servlet is available at the `artifactory/` path. However a filter redirects all paths outside of `artifactory/` to the artifactory servlet. Thus instead of linking to the URL http://localhost:8080/artifactory/libs-release-local you can just link to http://localhost:8080/libs-release-local (i.e. omitting the subpath `artifactory/`).

### Runtime options
Inject the environment variable `RUNTIME_OPTS` when starting a container to set Tomcat's runtime options (i.e. `CATALANA_OPTS`). The most common use case is to set the heap size:

    docker run -e RUNTIME_OPTS="-Xms256m -Xmx512m" -P mattgruter/artifactory
