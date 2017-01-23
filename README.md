## Artifactory
[![](https://images.microbadger.com/badges/image/gordonff/rpi-artifactory-oss.svg)](https://microbadger.com/images/gordonff/rpi-artifactory-oss "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/gordonff/rpi-artifactory-oss.svg)](https://microbadger.com/images/gordonff/rpi-artifactory-oss "Get your own version badge on microbadger.com")


Run [Artifactory](http://www.jfrog.com/home/v_artifactory_opensource_overview) inside a Docker container. Ported from the artificatory image provided by [Matt Gruter](https://registry.hub.docker.com/u/mattgruter/artifactory/).

Tested on a Raspberry PI 3. The only significant change from the default configuration is lowering the amount of java heap from 2 gigabytes to 512 megabytes.

### Volumes
Artifactories `data`, `logs` and `backup` directories are exported as volumes:

    /artifactory/data
    /artifactory/logs
    /artifactory/backup

### Ports
The web server is accessible through port `8081`.

### Example

In the Raspberry Pi terminal enter:

    docker run -p 8081:8081 gordonff/rpi-artifactory-oss

After 15 minutes or so, point an RPI web-browser at http://localhost:8080 to see the Artifactory home page. This page should be visible from other hosts over the network too.

### URLs
The artifactory servlet is available at the `artifactory/` path. However a filter redirects all paths outside of `artifactory/` to the artifactory servlet. Thus instead of linking to the URL http://localhost:8080/artifactory/libs-release-local you can just link to http://localhost:8080/libs-release-local (i.e. omitting the subpath `artifactory/`).
