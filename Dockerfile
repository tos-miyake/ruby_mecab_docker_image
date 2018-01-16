FROM ruby:2.3.5
ENV RAILS_ENV: test
ENV TZ: "/usr/share/zoneinfo/Asia/Tokyo"
ENV LANG: ja_JP.UTF-8
ENV LC_ALL: C.UTF-8
ENV LANGUAGE: ja_JP.UTF-8

RUN apt-get update -qq && apt-get install -y fonts-migmix unzip mysql-client
# install phantomjs
RUN curl --location --silent https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 | \
    tar xj -C /tmp --strip-components=1 && \
    mv /tmp/bin/phantomjs /usr/local/bin/phantomjs && \
    rm -rf /tmp/*
# mecab install
RUN wget https://github.com/taku910/mecab/archive/master.zip && \
    unzip master.zip && \
    cd mecab-master/mecab && \
    ./configure --enable-utf8-only && \
    make
RUN cd mecab-master/mecab && \
    make install && \
    ldconfig
RUN apt-get install -y mecab-ipadic-utf8
