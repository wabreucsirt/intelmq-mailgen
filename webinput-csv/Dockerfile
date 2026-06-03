FROM ubuntu:22.04

ARG REVISION

ENV REVISION=${REVISION}

COPY common/setup-apt.sh /opt/
RUN sed -i 's/\r$//' /opt/setup-apt.sh && chmod +x /opt/setup-apt.sh
RUN /opt/setup-apt.sh node

RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y nodejs git

RUN npm install --global yarn

COPY webinput-csv/init /opt/init
RUN find /opt/init -name "*.sh" -exec sed -i 's/\r$//' {} \; -exec chmod +x {} \;

WORKDIR /opt/

RUN git clone https://github.com/Intevation/intelmq-webinput-csv.git

WORKDIR /opt/intelmq-webinput-csv/client

RUN git checkout $REVISION

EXPOSE 8080

CMD ["/opt/init/startup-spa.sh"]

