      FROM gliderlabs/alpine:latest
      MAINTAINER Mateusz Pawlowski 
      RUN apk --update add \
        py-yaml py-jinja2  py-paramiko py-setuptools git py-pip perl py-simplejson
      RUN apk add py-httplib2 py-netifaces py-msgpack --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/
      RUN pip install python-novaclient python-keyczar boto
      RUN apk add openssh
      RUN mkdir /etc/ansible/
      RUN echo '[local]\nlocalhost\n' > /etc/ansible/hosts
      RUN mkdir /opt/ansible/ -p
      RUN git clone http://github.com/ansible/ansible.git /opt/ansible/ansible
      WORKDIR /opt/ansible/ansible
      RUN git checkout v1.9.1-1
      RUN git submodule update --init
      ENV PATH /opt/ansible/ansible/bin:/bin:/usr/bin:/sbin:/usr/sbin
      ENV PYTHONPATH /opt/ansible/ansible/lib
      ENV ANSIBLE_LIBRARY /opt/ansible/ansible/library
      RUN mkdir /ansible
      WORKDIR /ansible

