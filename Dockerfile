FROM ekapusta/alpine-sshd

RUN \
  apk --no-cache add git perl && \
  # Add group named "git"
  addgroup git && \
  # Add user without password to group "git" with name "git"
  adduser -D -G git -s /bin/sh git && \
  # Unlock git account (as it was with empty password)
  passwd -u git && \
  # Forbid SSH password auth for git user
  ( \
    echo ""; \
    echo "# Gitolite changes from $(date)"; \
    echo "Match User git"; \
    echo "    PasswordAuthentication no"; \
  ) >> /etc/ssh/sshd_config && \
  VOL-save /etc/ssh

USER git
WORKDIR /home/git

ENV PATH /home/git/gitolite/src:$PATH
ENV GITOLITE_REMOTE git://github.com/sitaramc/gitolite

# You can use it to setup first time
ENV GITOLITE_ADMIN_KEY ""
# .. or mount host file to /home/gitolite/admin.pub

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
