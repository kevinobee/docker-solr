[![Solr logo](https://raw.githubusercontent.com/docker-library/docs/master/solr/logo.png "See more on the Solr homepage")](http://lucene.apache.org/solr/)

# Solr in Docker

This GitHub repository defines a Docker container for running Solr on Windows.

The images used in this repository are based on Windows Container technology and can only be run using Docker Engine for Windows Containers.

For Solr images that run on Linux-based containers refer to the [official Solr page](https://store.docker.com/images/solr) on the Docker Store.

## What is Apache Solr?

Solr is the popular, blazing-fast, open source enterprise search platform built on Apache Lucene™.

Learn more on the [Solr homepage](http://lucene.apache.org/solr/) and in the [Solr Reference Guide](https://www.apache.org/dyn/closer.cgi/lucene/solr/ref-guide/). For more general information refer to the [Apache Solr](wikipedia.org/wiki/Apache_Solr) wikipedia page.


## Getting Started

Build the Dockerfile and tag the image:
```
docker build -t kevinobee/solr -m 4GB .
```

To start the Solr container:
```
docker run --name my-solr -d kevinobee/solr
```

To get the IP address of the running container:
```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' my-solr
```

To view the Solr instance running within the container in a browser run the following command.
```
Start-Process ("http://{0}:8983" -f (docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' my-solr))
```

To stop the running container:
```
docker stop my-solr
```

To remove all stopped containers:
```
docker container prune
```