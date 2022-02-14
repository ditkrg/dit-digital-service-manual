# Deployment

## Strategy

All software at DIT is packaged using Docker and will be running on Kubernetes. That being said, each piece of software must contain these valid documents:

1. Dockerfile: Specifies instructions of how to build the docker image for the software. 
2. .dockerignore: Specifies which files must be ignored when building the docker image.

## Dockerfile

The Dockerfile is a standard file that gives out instruction on how to build an image for the source code. Diffberent technology stacks have different base images on the top of which the new image is built. DIT has a local registry for all needed images. The base images used in this Dockerfile must be coming from our local registry. If the on-prem registry does not contain the base images that you need, speak to the Head of DevOps so that they are made available. If it is absolutely necessary to use an image that for some reasons cannot be hosted on our local registry, speak to the Head of DevOps to obtain approval. Otherwise, the change is considered a bug. 

See also: [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)

## Docker Layer Caching 

Docker creates container images using layers. Each command that is found in a `Dockerfile` creates a new layer. Each layers contains the filesystem changes of the image between the state before the execution of the command and the state after the execution of the command.

Docker uses a layer cache to optimize the process of building Docker images and make it faster.

Docker Layer Caching mainly works on `RUN`, `COPY` and `ADD` commands.

Image layers in the Dockerfile must be properly cached and necessary techniques to invalidate the cache must be put in place. Here is an example of how caching the layers could be achieved:


```dockerfile
FROM reg.dev.krd/library/ubuntu:20.04 AS base

COPY file.txt /target.txt
RUN apt-get update -qq && apt-get install -y postgresql-client
```

In this example, when building the dockerfile, any changes to the `file.txt` will result in reinstalling the dependencies; which is most likely not what we want. we can fix that by simply moving the copy command below the run command:

```dockerfile
FROM reg.dev.krd/library/ubuntu:20.04 AS base

RUN apt-get update -qq && apt-get install -y postgresql-client
COPY file.txt /target.txt
```

This way, even when we make changes to the `file.txt`, we do not have to reinstall the dependencies.

We also recommend reading the official [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/).

