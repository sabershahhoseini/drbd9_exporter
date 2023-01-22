FROM golang:1.19-alpine as builder

RUN apk add --no-cache make gcc musl-dev

WORKDIR /src
COPY . .
RUN make && CGO_ENABLED=0 go build

################################################################################

FROM alpine:3.17

MAINTAINER "Saber Shahhoseini <sabershahhoseini@gmail.com>"

COPY --from=builder /src/drbd9_exporter /usr/

EXPOSE     9481
ENTRYPOINT ["/usr/drbd9_exporter"]
