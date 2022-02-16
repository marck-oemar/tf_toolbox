# CI/CD container image toolbox with terraform and aws cli. # added comment # very important change

ARG FLUX_CLI_VERSION=v0.26.3-amd64
ARG TF_VERSION=1.0.2

# stage 1
FROM fluxcd/flux-cli:${FLUX_CLI_VERSION} AS flux-cli

# stage 2
FROM hashicorp/terraform:${TF_VERSION}

COPY --from=flux-cli /usr/local/bin/flux /usr/local/bin/flux 

ARG AWS_CLI_VERSION=1.16.263

ARG HELM_VERSION=3.8.0
ARG HELM_BASE_URL="https://get.helm.sh"

ARG KUBECTL_VERSION="1.23.3" 

ARG EKSCTL_VERSION="0.83.0"

RUN apk --update --no-cache add \
    wget \
    curl \
    groff \
    less \     
    python3 \
    py3-pip \
    jq \
    git

RUN pip3 install --no-cache-dir \
    awscli==$AWS_CLI_VERSION 

RUN wget ${HELM_BASE_URL}/helm-v${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xz \
    && mv linux-amd64/helm /usr/bin/helm \
    && chmod +x /usr/bin/helm \
    && rm -rf linux-amd64

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod u+x kubectl \
    && mv kubectl /bin/kubectl

RUN curl -sL "https://github.com/weaveworks/eksctl/releases/download/v${EKSCTL_VERSION}/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp \
    && mv /tmp/eksctl /usr/bin \
    && chmod +x /usr/bin/eksctl

RUN pip3 install --no-cache-dir \
    yq