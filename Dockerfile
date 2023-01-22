FROM golang:1.19-alpine as builder
RUN apk add --no-cache make gcc musl-dev

COPY . /src
RUN make -C /src install PREFIX=/pkg GO_BUILDFLAGS='-mod vendor'

################################################################################

FROM alpine:latest
MAINTAINER "Ben Cartwright-Cox <bencartwrightcox@monzo.com>"

COPY --from=builder /pkg/ /usr/

EXPOSE     9481
ENTRYPOINT ["/usr/bin/drbd9_exporter"]
