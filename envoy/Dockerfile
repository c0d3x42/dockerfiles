FROM envoyproxy/envoy-alpine:latest

COPY envoy.yaml /etc/envoy/envoy.yaml

COPY CA_crt.pem /etc
COPY cert_crt.pem cert_key.pem /etc/

