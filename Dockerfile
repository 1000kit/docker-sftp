FROM 1000kit/base

MAINTAINER 1000kit <docker@1000kit.org>

LABEL org.1000kit.vendor="1000kit" \
      org.1000kit.license=GPLv3 \
      org.1000kit.version=1.0.0


# install User
USER root

ADD install/* /opt/

RUN yum -y install openssh-server openssh-client && yum clean all \
    && mkdir -p /var/run/sshd \
    && groupadd --system sftp \
    && mv /opt/sshd_config /etc/ssh/sshd_config \
    && ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N '' \
    && ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' \
    && ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N '' \
    && chmod 755 /opt/*.sh

EXPOSE 22

ENTRYPOINT ["/opt/initUser.sh"]

CMD ["/bin/bash", "/opt/startSSHD.sh"]


#END
