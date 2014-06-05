FROM      ubuntu
MAINTAINER Dustin Sallings "dustin@spy.net"
 
ADD http://cbfs-ext.hq.couchbase.com/couchbase-dist/couchbase-server-enterprise_2.2.0_x86_64.deb /tmp/couchbase-server-enterprise_2.2.0_x86_64.deb
 
RUN apt-get update
RUN apt-get install -y librtmp0 python-httplib2
RUN dpkg -i /tmp/couchbase-server-enterprise_2.2.0_x86_64.deb
RUN rm /tmp/couchbase-server-enterprise_2.2.0_x86_64.deb
RUN /etc/init.d/couchbase-server stop
RUN rm -r /opt/couchbase/var/lib
 
ADD http://cbfs-ext.hq.couchbase.com/dustin/software/confsed/confsed.lin64.gz /usr/local/sbin/confsed.gz
RUN gzip -d /usr/local/sbin/confsed.gz
RUN chmod 755 /usr/local/sbin/confsed
 
ADD http://cbfs-ext.hq.couchbase.com/dustin/software/docker/cb/couchbase-script /usr/local/sbin/couchbase
RUN chmod 755 /usr/local/sbin/couchbase
 
# 7081 is 8091 with rewrites
EXPOSE 7081 8092 11210
 
CMD /usr/local/sbin/couchbase
