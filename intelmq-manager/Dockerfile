FROM ubuntu:22.04

ARG INTELMQ_REVISION
ARG INTELMQ_MANAGER_REVISION

ENV INTELMQ_REVISION=${INTELMQ_REVISION}
ENV INTELMQ_MANAGER_REVISION=${INTELMQ_MANAGER_REVISION}
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git python3-pip sudo apache2 libapache2-mod-wsgi-py3

RUN useradd -d /opt/intelmq -U -s /bin/bash intelmq \
    && usermod -aG intelmq www-data \
    && mkdir -p /opt/intelmq \
    && chown -R intelmq:intelmq /opt/intelmq

# Install intelmq (needed for intelmqsetup)
RUN git clone https://github.com/certtools/intelmq.git /opt/intelmq_src
WORKDIR /opt/intelmq_src
RUN git config --global --add safe.directory /opt/intelmq_src \
    && git checkout $INTELMQ_REVISION \
    && pip3 install . \
    && sed -i 's/ruamel\.yaml/ruamel_yaml/' /opt/intelmq_src/intelmq.egg-info/requires.txt

# Install intelmq-manager
WORKDIR /opt
RUN git clone https://github.com/certtools/intelmq-manager.git
WORKDIR /opt/intelmq-manager
RUN git config --global --add safe.directory /opt/intelmq-manager \
    && git checkout $INTELMQ_MANAGER_REVISION \
    && pip3 install .

# intelmqsetup enables the manager Apache config (Alias) and sets up /etc/intelmq/manager/
RUN intelmqsetup

# The API runs in a separate container; proxy /intelmq/ to intelmq-api:8080.
# intelmqsetup may have installed its own intelmq-api.conf — remove it to avoid conflicts.
RUN rm -f /etc/apache2/conf-enabled/intelmq-api.conf \
    && rm -f /etc/apache2/conf-available/intelmq-api.conf

COPY intelmq-manager/proxy.conf /etc/apache2/conf-available/intelmq-api-proxy.conf
RUN a2enconf intelmq-api-proxy \
    && a2enmod proxy proxy_http

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
