FROM flownative/base:1

ENV HELM_VERSION v3.0.2
ENV HELM_HOME=/root/.helm
ENV HELM_PLUGIN_PUSH_VERSION v0.8.1

RUN set -ex \
    && curl -sSL https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz | tar xz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -rf linux-amd64

RUN set -ex \
    helm plugin install https://github.com/chartmuseum/helm-push.git --version ${HELM_PLUGIN_PUSH_VERSION}

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
