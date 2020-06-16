FROM golang:alpine as builder
RUN apk update && apk add --no-cache ca-certificates && update-ca-certificates

FROM scratch AS runtime
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /usr/local/go/lib/time/zoneinfo.zip /
ENV ZONEINFO=/zoneinfo.zip
COPY ./out/client /app/client
EXPOSE 8080/tcp
WORKDIR /app
ENTRYPOINT  ["./client"]
