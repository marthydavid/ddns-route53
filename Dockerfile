FROM python:3-alpine
RUN apk add --no-cache bash \
    curl     \
    gettext  \
    python3  \
    bind-tools && \
    pip3 install awscli

ADD batch.json.template /usr/local/bin/batch.json.template
ADD ddns.sh /usr/local/bin/ddns.sh
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN adduser -D -u 1000 ddns \
    && chown -R 1000:1000 /usr/local/bin \
    && chmod -R 775 /usr/local/bin
USER 1000
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
