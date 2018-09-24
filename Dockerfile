FROM openshift/base-centos7

#USER root

RUN yum --enablerepo=extras -y install epel-release && \
    yum update -y && \
    yum -y install python \
    python-devel \
    python-pip \
    mercurial && yum clean all

# Install dev cron
RUN pip install -e hg+https://bitbucket.org/dbenamy/devcron#egg=devcron

ADD ./etc/crontab /cron/crontab

ADD start.sh start.sh
RUN chown -R 1001:0 ./start.sh && chmod +x ./start.sh

RUN mkdir -p /opt/app-root/src/conf && \
    chown -R 1001:0 /opt/app-root/src/conf && chmod -R og+rwx /opt/app-root/src/conf

#USER 1001

CMD ["devcron.py", "/cron/crontab"]