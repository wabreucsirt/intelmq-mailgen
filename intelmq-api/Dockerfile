FROM ubuntu:22.04

ARG INTELMQ_REVISION
ARG INTELMQ_API_REVISION

ENV INTELMQ_REVISION=${INTELMQ_REVISION}
ENV INTELMQ_API_REVISION=${INTELMQ_API_REVISION}
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git python3-pip python3-psycopg2 sudo sqlite3

RUN useradd -d /opt/intelmq -U -s /bin/bash intelmq \
    && usermod -aG intelmq www-data \
    && mkdir -p /opt/intelmq \
    && chown -R intelmq:intelmq /opt/intelmq

# Install intelmq (provides intelmqctl, required by the API)
RUN git clone https://github.com/certtools/intelmq.git /opt/intelmq_src
WORKDIR /opt/intelmq_src
RUN git config --global --add safe.directory /opt/intelmq_src \
    && git checkout $INTELMQ_REVISION \
    && pip3 install -e . \
    && sed -i 's/ruamel\.yaml/ruamel_yaml/' /opt/intelmq_src/intelmq.egg-info/requires.txt

# Install intelmq-api
WORKDIR /opt
RUN git clone https://github.com/certtools/intelmq-api.git
WORKDIR /opt/intelmq-api
RUN git checkout $INTELMQ_API_REVISION \
    && pip3 install -e .

RUN mkdir -p /opt/intelmq-api/etc/intelmq/ \
    && cp /opt/intelmq-api/contrib/api-sudoers.conf /opt/intelmq-api/etc/intelmq/api-sudoers.conf

COPY intelmq/api-config/api-config.json /etc/intelmq/api-config.json

RUN python3 contrib/initesqlite.py \
    && intelmq-api-adduser --user admin --password secret

EXPOSE 8080

CMD ["uvicorn", "intelmq_api.main:app", "--host", "0.0.0.0", "--port", "8080"]
