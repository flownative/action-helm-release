FROM flownative/base:1

ENV HELM_VERSION v3.0.2
ENV HELM_HOME=/root/.helm
ENV HELM_PLUGIN_PUSH_VERSION v0.8.1

# We need Git for "helm plugin install"
RUN apt-get update \
    && apt-get install git \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/log/apt \
    && rm -rf /var/log/dpkg.log

RUN curl -sSL https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar xz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -rf linux-amd64

RUN /usr/local/bin/helm plugin install https://github.com/chartmuseum/helm-push.git --version ${HELM_PLUGIN_PUSH_VERSION}

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
