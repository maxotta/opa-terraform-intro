FROM ubuntu:latest
LABEL maintainer="maxmilio@kiv.zcu.cz"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get autoremove && apt-get autoclean
RUN apt-get -y install apt-utils curl
RUN apt-get -y install python3 python3-pip
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

RUN curl -L -o /usr/bin/opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64 ; \
    chmod 755 /usr/bin/opa
