#!/bin/sh
[[ ! -z "$LOGIN" ]] || exit 1

[[ -f /etc/ssh/ssh_host_rsa_key ]] || \
  ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa

usermod -l "$LOGIN" `stat -c '%U' $SSH_HOME`
echo -en "$AUTHORIZED_KEYS" > $SSH_HOME/.ssh/authorized_keys

## start
rm /run/sshd.pid
exec /usr/sbin/sshd -D "$@"
