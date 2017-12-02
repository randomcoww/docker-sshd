FROM alpine:latest

ENV SSH_HOME /home/sshuser
ENV SSH_USER sshuser

RUN \
  apk add --no-cache openssh bash shadow && \
  \
  adduser -h $SSH_HOME -s /bin/bash -D $SSH_USER && \
  passwd -d $SSH_USER && \
  \
  mkdir -p $SSH_HOME/.ssh && \
  touch $SSH_HOME/.ssh/authorized_keys && \
  chmod 700 $SSH_HOME/.ssh && \
  chmod 600 $SSH_HOME/.ssh/authorized_keys && \
  chown -R $SSH_USER:$SSH_USER $SSH_HOME/.ssh

COPY sshd_config /etc/ssh/sshd_config

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]