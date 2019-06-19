FROM alpine:latest
  
ARG DOCUMIZE_VERSION=v3.0.0

RUN apk add --no-cache curl

WORKDIR /app

RUN curl -L -o documize "https://github.com/documize/community/releases/download/${DOCUMIZE_VERSION}/documize-community-linux-amd64" \
    && chmod 755 documize

ADD config.conf /app

ENTRYPOINT ["./documize", "config.conf"]

EXPOSE 3000
