FROM postgres:12.3
MAINTAINER Xetera <me@xetera.dev>

ENV PG_VERSION 12.3

RUN set -xe  \
    && apt-get update && apt-get install -y build-essential curl postgresql-server-dev-12 \
    && mkdir /build \
    && curl https://ftp.postgresql.org/pub/source/v$PG_VERSION/postgresql-$PG_VERSION.tar.bz2 \
            -o /build/postgresql-$PG_VERSION.tar.bz2 \
    && cd /build/ && tar xvf postgresql-$PG_VERSION.tar.bz2 \
    && cd /build/postgresql-$PG_VERSION/contrib/cube  \
    && sed -i 's/#define CUBE_MAX_DIM (100)/#define CUBE_MAX_DIM (2000)/' cubedata.h \
    && USE_PGXS=true make && USE_PGXS=true make install \
    && rm -rf /build/ \
    && apt-get purge -y build-essential curl postgresql-server-dev-12 \
    && apt-get autoremove -y
