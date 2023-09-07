FROM openjdk:17.0.1-jdk-slim

RUN apt-get update && \
    apt-get install -y software-properties-common curl vim && \
    apt-get install -y python3-pip && \
    pip install ansible-rulebook ansible ansible-runner aiokafka


WORKDIR /opt/
COPY . /opt

RUN ansible-galaxy collection install ansible.eda

## Hacky to avoid user issues on OpenShift
RUN cp -r /root/.ansible /opt/.ansible && \
    cp -r /root/.ansible /.ansible && \
    chmod -R 770 /.ansible && \
    chmod -R 777 /opt
USER 1001


ENV RULEBOOK="hello-world/rulebook-webhook.yml"

CMD ansible-rulebook --rulebook $RULEBOOK -E KAFKA_HOST,KAFKA_PORT -i inventory.yml --verbose
