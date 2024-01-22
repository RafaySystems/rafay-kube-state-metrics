ARG GOVERSION=1.21.6
FROM golang:${GOVERSION} as builder
WORKDIR /go/src/RafaySystems/kube-state-metrics/
COPY . /go/src/RafaySystems/kube-state-metrics/

RUN make build-local

FROM gcr.io/distroless/static:latest
COPY --from=builder /go/src/RafaySystems/kube-state-metrics/kube-state-metrics /

USER nobody

ENTRYPOINT ["/kube-state-metrics", "--port=8080", "--telemetry-port=8081"]

EXPOSE 8080 8081
