FROM alpine:3.10

RUN apk update -f \
  && apk --no-cache add -f \
  openssl \
  openssh-client \
  coreutils \
  bind-tools \
  curl \
  socat \
  tzdata \
  oath-toolkit-oathtool \
  tar \
  && rm -rf /var/cache/apk/*

ENV LE_CONFIG_HOME /acme.sh

ENV AUTO_UPGRADE 1

#Install
ADD ./ /install_acme.sh/
ADD docker/entry.sh /entry.sh
RUN cd /install_acme.sh && ([ -f /install_acme.sh/acme.sh ] && /install_acme.sh/acme.sh --install || curl https://get.acme.sh | sh) && rm -rf /install_acme.sh/

RUN ln -s  /root/.acme.sh/acme.sh  /usr/local/bin/acme.sh && crontab -l | grep acme.sh | sed 's#> /dev/null##' | crontab -

VOLUME /acme.sh

ENTRYPOINT ["/entry.sh"]
CMD ["--help"]
