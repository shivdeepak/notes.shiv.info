---
layout: post
title:  "Using Dev Containers with Docker Compose in Cursor"
date:   2025-04-29 12:27:39 -0700
categories: vscode
---

Containerization has revolutionized how we develop and deploy applications. Conatiners provide a consistent environments with flexible OS and package configurations across all development stages. While Kubernetes can run containers in production, developers can use Docker for local development. 

Modern applications often require multiple services (like databases, caches, message queues, or seperate microservices) running simultaneously. [Docker Compose](https://docs.docker.com/compose/) excels at orchestrating these multi-container development environments, making it the go-to tool for local development workflows.

Cursor (or any VS Code Equivalent) has a very nice integration with Docker Compose through [Microsoft's Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension.

With Dev Containers, you could manage the docker compose stack from within Cursor. Moreover, you could also load the Cursor project inside docker container, and Cursor's terminal shell (^ + ~) is spawned within the container, which is nice!

To configure your project with Dev Containers, you need to create a `.devcontainer` directory in the root of your project. Inside this directory, you will place your `docker-compose.yml` file, and you create sub directories for individual services (if required).

Here is an example from [`mcp-sniffer`](https://github.com/shivdeepak/mcp-sniffer/tree/main/.devcontainer), where I am using Dev Containers to run python backend, react frontend, and a nginx reverse proxy.

```
.devcontainers/
    mcp-sniffer-container/
        Dockerfile
        devcontainer.json
    nginx-container/
        default.conf
    frontend-container/
        Dockerfile
        start.sh
    docker-compose.yml
```

This directory structure works both from within Cursor with Dev Containers extension, and from Terminal with `docker compose` commands.

This is nice because you can use either of the two workflows for development. For instance, I use `docker compose` commands during intial setup to ensure all containers are 
building and running properly. Once that's done, I switch
to Cursor, and use Dev Containers commands.

Once you have a working Dev Containers setup. You should be able to use these Command Palette (⌘ + ⇧ + P) commands to manage your Dev Containers life-cycle.

1. (Re)opens the (current) folder in a container
    - ⌘ + ⇧ + P > `Dev Containers: Open Folder in Container`
    - ⌘ + ⇧ + P > `Dev Containers: Reopen in Container`
    - Equivalent to: `docker compose up -d`
2. Open the current folder in Locally (exit Dev Container)
    - ⌘ + ⇧ + P > `Dev Containers: Reopen Folder Locally`
3. Rebuilds the container without losing data
    - ⌘ + ⇧ + P > `Dev Containers: Rebuild Container`
    - Equivalent to: `docker compose build --no-cache && docker compose up -d`
4. Completely rebuilds the container and reopens it
    - ⌘ + ⇧ + P > `Dev Containers: Rebuild and Reopen in Container`
    - Equivalent to: `docker compose down && docker compose build --no-cache && docker compose up -d`
5. Stops the current container
    - ⌘ + ⇧ + P > `Dev Containers: Stop Container`
    - Equivalent to: `docker compose stop`
6. Attaches to an already running container
    - ⌘ + ⇧ + P > `Dev Containers: Attach to Running Container`
    - Equivalent to: `docker exec -it <container_id> bash`
7. Opens the container's log file
    - ⌘ + ⇧ + P > `Dev Containers: Open Log File`
    - Equivalent to: `docker compose logs`


### Bottomline

Working with Dev Containers is nice, but it comes with additional complexity, and learning curve.

If you don't mind it, then great! If you do, then you can still use the trusty `docker compose` commands and it will work just
fine.
