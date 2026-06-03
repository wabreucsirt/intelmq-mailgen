FROM ubuntu:22.04

ARG REVISION

ENV REVISION=${REVISION}

COPY common/setup-apt.sh /opt/
RUN sed -i 's/\r$//' /opt/setup-apt.sh && chmod +x /opt/setup-apt.sh
RUN /opt/setup-apt.sh node

RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y nodejs git

RUN npm install --global yarn

COPY fody/startup-spa.sh /opt/startup-spa.sh
RUN sed -i 's/\r$//' /opt/startup-spa.sh && chmod +x /opt/startup-spa.sh

WORKDIR /opt/src/

RUN git clone https://github.com/Intevation/intelmq-fody.git

WORKDIR /opt/src/intelmq-fody

RUN git checkout $REVISION

EXPOSE 8080

CMD ["/opt/startup-spa.sh"]

