FROM ekapusta/alpine-sshd

RUN \
  apk --no-cache add git perl && \
  # Add group named "gitolite"
  addgroup gitolite && \
  # Add user without password to group "gitolite" with name "gitolite"
  adduser -D -G gitolite -s /bin/sh gitolite && \
  # Unlock gitolite account (as it was with empty password)
  passwd -u gitolite && \
  # Forbid SSH password auth for gitolite user
  ( \
    echo ""; \
    echo "# Gitolite changes from $(date)"; \
    echo "Match User gitolite"; \
    echo "    PasswordAuthentication no"; \
  ) >> /etc/ssh/sshd_config && \
  VOL-save /etc/ssh

USER gitolite
WORKDIR /home/gitolite

ENV SSHD_OPTION_PERMIT_ROOT_LOGIN no 

ENV PATH /home/gitolite/gitolite/src:$PATH
ENV USER gitolite
ENV GITOLITE_REMOTE git://github.com/sitaramc/gitolite

# You can use it to setup first time
ENV GITOLITE_ADMIN_KEY ""
# .. or mount host file to /home/gitolite/admin.pub
ENV GITOLITE_ADMIN_NAME admin

RUN \
  GITOLITE_STABLE=$(\
    git ls-remote --tags $GITOLITE_REMOTE | \
    grep -o 'v3.*[0-9]$' | \
    sort -t '.' -k 2,3 -g | \
    tail -1 \
  ) && \
  git clone --depth 1 --branch $GITOLITE_STABLE $GITOLITE_REMOTE && \
  mkdir -p .ssh && touch .ssh/authorized_keys

USER root

# Add init hooks
COPY cm.d/* /dcr/cm.d/
