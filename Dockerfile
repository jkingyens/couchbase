FROM ubuntu:12.04
WORKDIR /work
RUN apt-get update
RUN apt-get install -y build-essential libmozjs-dev automake sqlite3 libglib2.0-dev ruby libicu-dev libtool pkg-config check libssl-dev git wget python python-pip libv8-dev erlang-nox erlang-dev erlang-src gcc g++ automake autoconf make curl dmidecode libsnappy-dev libicu-dev libevent-dev libcurl4-openssl-dev libcloog-ppl0
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo
RUN chmod a+x /usr/bin/repo
RUN repo init -u git://github.com/couchbase/manifest.git -m released/2.2.0.xml
RUN repo sync
RUN make
RUN addgroup --gid 999 couchbase
RUN useradd --uid 999 --gid 999 couchbase
RUN chown -R couchbase:couchbase *
USER couchbase
EXPOSE 8091 8092 11209 11210 11211
CMD [ "install/bin/couchbase-server" ]
