# Copyright The OpenTelemetry Authors
# SPDX-License-Identifier: Apache-2.0


FROM apache/kafka:3.9.1

USER root
ARG OTEL_JAVA_AGENT_VERSION

USER appuser

ADD --chown=appuser:appuser https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v$OTEL_JAVA_AGENT_VERSION/opentelemetry-javaagent.jar /tmp/opentelemetry-javaagent.jar

ENV KAFKA_CONTROLLER_LISTENER_NAMES=CONTROLLER
ENV KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT
ENV KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS=3000
ENV KAFKA_PROCESS_ROLES=controller,broker
ENV KAFKA_NODE_ID=1
ENV KAFKA_METADATA_LOG_SEGMENT_MS=604800000
ENV KAFKA_METADATA_MAX_RETENTION_MS=604800000
ENV KAFKA_METADATA_LOG_MAX_RECORD_BYTES_BETWEEN_SNAPSHOTS=20971520
ENV KAFKA_AUTO_CREATE_TOPICS_ENABLE=false
# AGENT: single broker detected (KAFKA_NODE_ID=1); RF cannot exceed broker count — scale to a 3-broker cluster and set this to 3 for production safety
ENV KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1
# AGENT: single broker detected (KAFKA_NODE_ID=1); RF cannot exceed broker count — scale to a 3-broker cluster and set this to 3 for production safety
ENV KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR=1
ENV KAFKA_OPTS="-javaagent:/tmp/opentelemetry-javaagent.jar -Dotel.jmx.target.system=kafka-broker"
ENV CLUSTER_ID=ckjPoprWQzOf0-FuNkGfFQ
