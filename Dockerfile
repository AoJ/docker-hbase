FROM aooj/base
MAINTAINER AooJ "aooj@n13.cz"

# Install Java7
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install -y git maven oracle-java7-installer && apt-get clean
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle/

RUN git clone https://github.com/apache/hbase.git /opt/hbase

WORKDIR /opt/hbase

RUN git checkout tags/0.94.17
RUN mvn clean package -DskipTests

# ZK
EXPOSE 2181

# HMaster
EXPOSE 16000

# HMaster Web
EXPOSE 16010

# RegionServer
EXPOSE 16020

# RegionServer Web
EXPOSE 16030

VOLUME /tmp/hbase-root/hbase

CMD ["./bin/hbase", "master", "start"]
