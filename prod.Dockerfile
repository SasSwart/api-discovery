FROM alpine:latest as certs
RUN apk --update add ca-certificates

ARG TAG=latest
FROM scratch

WORKDIR /
COPY --from=certs /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY dist/products /products

ENTRYPOINT ["/products"]