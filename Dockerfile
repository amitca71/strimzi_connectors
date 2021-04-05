FROM strimzi/kafka:0.20.0-kafka-2.6.0
USER root:root
RUN mkdir -p /opt/kafka/plugins/jdbc
RUN mkdir -p /opt/kafka/plugins/s3
COPY ./confluentinc-kafka-connect-jdbc-10.0.2/lib /opt/kafka/plugins/jdbc/
COPY ./confluentinc-kafka-connect-s3-10.0.0/ /opt/kafka/plugins/confluent-s3/
USER 1001
