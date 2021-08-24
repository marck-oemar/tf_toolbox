# My Terraform toolbox container image

This image is used for running in a CICD pipeline and/or local development. 

Important tooling:
- terraform
- aws cli

## Smoke testing for the container image

Smoke/unit testing is done with TestInfra https://testinfra.readthedocs.io/en/latest/index.html
TestInfra is written in Python and leverages pytest. 
Renatomefi has created a TestInfra docker image on Dockerhub that we can use: renatomefi/docker-testinfra:2

### Howto test

2) Create / alter test files in ./tests
1) Build and store the tf_toolbox image 
3) Run and daemonize the container, note the container id
```
docker run --rm -it -d --entrypoint /bin/sh --name tf_toolbox tf_toolbox:latest
```
4) Run TestInfra container with docker socket connected to the tf_toolbox container with mounted test folder volume, and pytest will collect and run defined tests
```
docker run --rm -t -v "$(pwd):/tests" -v /var/run/docker.sock:/var/run/docker.sock:ro \ 
renatomefi/docker-testinfra:2 \
-v \
--hosts="docker://< tf_toolbox container id >"
```

nee b
immortant change worthyu of release



