FROM amazon/aws-cli:2.11.15

RUN yum install -y \
    jq \
    unzip \
    gzip \
    && yum clean all \
    && rm -rf /var/cache/yum \
    && curl -L -o logcli-linux-amd64.zip https://github.com/grafana/loki/releases/download/v2.8.0/logcli-linux-amd64.zip \
    && unzip logcli-linux-amd64.zip \
    && mv logcli-linux-amd64 /usr/local/bin/logcli \
    && rm logcli-linux-amd64.zip

ADD export.sh /usr/local/bin/exportloki
WORKDIR /app

ENTRYPOINT [ "exportloki" ]