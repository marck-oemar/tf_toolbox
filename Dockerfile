# CI/CD container image toolbox with terraform and aws cli  
FROM hashicorp/terraform:1.0.2

ENV AWS_CLI_VERSION=1.16.263

RUN apk --update --no-cache add \
    curl \
    groff \
    less \     
    python3 \
    py3-pip \
    jq \
    git \
    && pip3 install --no-cache-dir awscli==$AWS_CLI_VERSION
