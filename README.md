# Creating a free private npm registry with Verdaccio and make it docker compatible

## Install Docker

Docker is a platform that enables you to combine an app plus its configuration and dependencies into a single, independently deployable unit called a container.

### Download and Install

You'll be asked to register for Docker Store before you can download the installer.

By default, Docker will use Linux Containers on Windows. Leave this configuration settings as-is when prompted in the installer.

[Get Docker for Windows](https://hub.docker.com/editions/community/docker-ce-desktop-windows)

### Check that Docker is ready to use

Once you've installed, open a new command prompt and run the following command:

    docker --version

If the command runs, displaying some version information, then Docker is successfully installed.

## Add Docker metadata

To run with Docker Image you need a Dockerfile — a text file that contains instructions for how to build your app as a Docker image. A docker image contains everything needed to start an instance of your app.

### Return to app directory

Since you opened a new command prompt in the previous step, you'll need to return to the directory you created your project in.

    cd spr-npmregistry

### Add a DockerFile

To create an empty Dockerfile, run the following command:

    echo . > Dockerfile

Please note that if you are using VS Code and you ran this command in VS Code terminal you may get parse error in line 1 of Dockerfile when building image. In that case press Ctrl+Shift+P to open Command palette in VS Code and then make use of Docker:Add Docker Files to Workspace command to generate Dockerfile from Visual Code.

Open the Dockerfile in the text editor of your choice and replace the contents with the following:

    FROM node:latest

    RUN git clone  https://github.com/sathyarajagopal/spr-npmregistry.git && \
        chown -R node /spr-npmregistry

    WORKDIR /spr-npmregistry
    USER node 
    RUN npm install

    WORKDIR /spr-npmregistry
    USER node
    CMD npm run start

    EXPOSE 4873

## Switch to Linux containers

Right click on Docker Desktop whale icon in systems tray and select "Switch to Linux containers..." only if the whale is currently running in windows container.

## Remove existing Docker image

You can run the following command to see a list of all images available on your machine. This is to check whether spr-npmregistry image already exists.

    docker image ls

### Delete the image

If spr-npmregistry image exists then delete the image using the following command:

    docker image rm -f spr-npmregistry

## Create Docker image

Run the following command:

    docker build -t spr-npmregistry .

The docker build command uses the information from your Dockerfile to build a Docker image.

The -t parameter tells it to tag (or name) the image as spr-npmregistry.
The final parameter tells it which directory to find the Dockerfile in (. specifies the current directory).

You can run the following command to see a list of all images available on your machine, including the one you just created.

    docker image ls

## Run Docker image

Docker image can be instantiated or run using any of the below methods:

### Method 1

A Docker container is an instance of your app, created from the definition and resources from your Docker image.

To run your app in a container, run the following command:

    docker run -it --rm -p 4873:4873 spr-npmregistry

Once the command completes, browse to http://localhost:8081/.

### Method 2

To run your app in a container, run the following command:

    docker-compose -f docker-compose.yaml up -d

Once the command completes, browse to http://localhost:8081/.

## Push to docker hub

Docker Hub is a central place to upload Docker images. Many products, including Node.js, can create containers based on images in Docker Hub.

### Login to Docker Hub

In your command prompt, run the following command:

    docker login

Use the username and password created when you downloaded Docker. You can visit the Docker Hub website to reset your password if needed.

### Upload image to Docker Hub

Re-tag (rename) your Docker image under your username and push it to Docker Hub using the following commands:

    docker tag spr-npmregistry [YOUR DOCKER USERNAME]/spr-npmregistry
    docker push [YOUR DOCKER USERNAME]/spr-npmregistry

## Remove Docker Containers

Run the below command to list all containers in your machine.

    docker container ls --all

Capture the container name from the previous command and run the below command to stop running containers.

    docker container stop <ctr1> <ctr2>

Now run the below command to remove the containers.

    docker container rm <ctr1> <ctr2>

## Prune unused docker objects

    docker system prune -a

Congratulations! You've successfully created a small, independent NPM registry that can be deployed and scaled using Docker containers.

These are the fundamental building blocks to get a Node.js application into a Docker container.

## References

1. https://nodejs.org/en/docs/guides/nodejs-docker-webapp/
2. https://buddy.works/guides/how-dockerize-node-application
3. https://medium.com/faun/creating-a-free-private-npm-registry-with-verdaccio-e1becdc542b
4. https://github.com/verdaccio/docker-examples
5. https://github.com/nodejs/docker-node/blob/master/README.md#how-to-use-this-image
6. https://github.com/nodejs/docker-node/blob/master/docs/BestPractices.md
7. https://docs.docker.com/engine/reference/builder/#entrypoint
8. https://hub.docker.com/r/verdaccio/verdaccio/dockerfile
9. Setup docker hub Verdaccio image running on a docker container using docker compose by mounting local drive - https://www.oskarlindgren.se/blog/private-npm-registry-with-verdaccio-2-2/