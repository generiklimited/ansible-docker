      FROM alpine:edge
      MAINTAINER Mateusz Pawlowski
      RUN apk --no-cache add \
        py-yaml py-jinja2  py-paramiko py-setuptools git py2-pip perl py-simplejson rsync \
        py-httplib2 openssh \
         && apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/  py-netifaces py-msgpack \
      && rm -rf /var/cache/apk/*
      RUN pip install --upgrade setuptools
      RUN pip install python-keyczar boto hvac
      RUN mkdir /etc/ansible/
      RUN echo "[local]" > /etc/ansible/hosts ; echo "localhost ansible_connection=local" >> /etc/ansible/hosts
      RUN mkdir /opt/ansible/ -p
      RUN git clone http://github.com/ansible/ansible.git /opt/ansible/ansible
      WORKDIR /opt/ansible/ansible
      RUN git checkout v2.1.2.0-0.5.rc5
      RUN git submodule update --init
      ENV PATH /opt/ansible/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin
      ENV PYTHONPATH /opt/ansible/ansible/lib
      ENV ANSIBLE_LIBRARY /opt/ansible/ansible/library
      RUN mkdir /ansible
      WORKDIR /ansible

