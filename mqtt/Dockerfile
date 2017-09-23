FROM alpine:3.6

# Install packages
RUN apk add --update mosquitto mosquitto-clients

# Expose MQTT port
EXPOSE 1883

ENTRYPOINT ["mosquitto"]
