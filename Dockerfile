FROM ubuntu:18.04

MAINTAINER Vilvamani Arumugam

ENV LAST_UPDATE=2021-04-30

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y tzdata locales

# AWS CLI needs the PYTHONIOENCODING environment varialbe to handle UTF-8 correctly:
ENV PYTHONIOENCODING=UTF-8

RUN apt-get install -y \
    less \
    man \
    ssh \
    python \
    python3-pip \
    python3-virtualenv \
    vim \
    vim-nox \
    zip \
    openjdk-8-jdk \
    openssh-server \
    curl \
    git \
    wget \
    build-essential



RUN mkdir -p /var/run/sshd
RUN ssh-keygen -A
ADD ./sshd_config /etc/ssh/sshd_config
RUN echo root:password123 | chpasswd

RUN  curl -sSL https://get.docker.com/ | sh
RUN apt-get update &&\
    apt-get clean -y && rm -rf /var/lib/apt/lists/*

RUN pip3 install awscli --upgrade

CMD ["/usr/sbin/sshd", "-D"]
