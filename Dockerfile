FROM node:slim

LABEL maintainer=Sophie

RUN \
  apt-get update -qq && apt-get -qqy --no-install-recommends install \
    curl ca-certificates gnupg2 && \
\
  echo 'deb http://dl.google.com/linux/chrome/deb/ stable main' \
    >> /etc/apt/sources.list && \
  curl -s https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  apt-get update -qq && apt-get -qqy --no-install-recommends install google-chrome-stable
