---
layout: post
title:  "Run anything as a Docker container"
date:   2025-02-06 21:40:39 -0700
categories: devex
---

Every now and then, I end up setting up a new tech stack, or a library for a project,
just to try out something new.

I have been using Docker for a while now, and I have found it to be a great way to
run anything as a container without polluting the host machine with unnecessary
packages and dependencies.

Here is my workflow for running anything as a container.

## 1. Create a Dockerfile

Find a base image that closely matches with your needes, add customizations on top of it
as needed. I usually pick between these docker images:

- [Python](https://hub.docker.com/_/python): `python:3.13` is a good choice for new python projects.
- [Node](https://hub.docker.com/_/node): `node:23` is a good choice for new Node.js projects.
- [Ruby](https://hub.docker.com/_/ruby): `ruby:3.4` is a good choice for new Ruby projects.
- [Ubuntu](https://hub.docker.com/_/ubuntu): `ubuntu:24.10` is a good choice if you are building something from scratch, but you don't care about image size.
- [Alpine](https://hub.docker.com/_/alpine): `alpine:3.21` is a good choice if you want a minimal image, and build a custom image from there for production use cases.

Note that more images are available on [Docker Hub](https://hub.docker.com/), and you could search for official images that closely matches with your needes.

Two more things to consider:

- All the above images could be downloaded with `latest` tag, but I don't prefer that approch because I like to lock image versions, which ensure that dependecies don't break.
- I also try to not use unofficial images on dockerhub because they tend not to be actively maintained, and also could have security vulnerabilities, malicious or not.

So, once you pick your image, you can use that as your base image, and add further customizations.

Here is a sample template to get started:

```Dockerfile
FROM python:3.13

RUN pip install --upgrade pip

ENV HELLO=WORLD

ENTRYPOINT ["echo", "Hello, World!"]
```

## 2. Build the image

```bash
docker build -t hello-world:latest .
```

## 3. Run the image

```bash
docker run -it hello-world:latest
```

### Run the image with a bash shell

```bash
docker run -it hello-world:latest /bin/bash
```

### Run the image with current directory mounted

```bash
docker run -it -v $(pwd):/app hello-world:latest /bin/bash
```

### Run the image with port forwarding

```bash
docker run -it -p 8080:8080 hello-world:latest /bin/bash
```

Now, there many different options when you run a docker image, and we will use this to run anything with docker.

Note that you don't want to keep running `docker build` after every file change, so you could volume mount with `-v`
option so that you app code is mounted into the container when you run it.

But, you will still want to rebuild docker image if any dependencies change. Which is acceptable.

So, if you are working on a python flask project, you can run the following command to start the flask server,
and do a volume mount so that your changes are reflected immediately.

```bash
docker run -it -v $(pwd):/app -p 8080:8080 flask-app:latest
```

Note that I am assuming that you have already built and setup flask app as a Docker image, and have setup necessary
entrypoint.

However, for a use case like running a flask app, I would probably go with `poetry` to manage dependencies on the host
machine, and avoid the overhead of running it as a docker container.

But, use-cases where I have to install a lot of dependencies, and native libraries, or more complex setups, I would
definitely choose docker over running it on the host machine.

## 4. Prune system for a clean slate

Docker images and their layers take a lot of disk space. So every once in a while
depending on how frequently I use docker, I usually run a full clean up to free
up disk space. This also sometimes addresses unexplinable errors during docker builds.

```bash
docker system prune --all
```
