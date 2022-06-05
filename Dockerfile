FROM ubuntu:20.04
RUN apt update
RUN apt install git -y
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt install default-jdk -y
RUN apt install maven -y
RUN apt install curl -y
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR boxfuse-sample-java-war-hello/
RUN mvn package

# Установка Tomcat
RUN groupadd tomcat
RUN useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
#RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.63/bin/apache-tomcat-9.0.63.tar.gz
RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.63/bin/apache-tomcat-9.0.63.tar.gz
RUN mkdir /opt/tomcat
RUN tar xzvf apache-tomcat-*tar.gz -C /opt/tomcat --strip-components=1
WORKDIR /opt/tomcat
RUN chgrp -R tomcat /opt/tomcat
RUN chmod -R g+r conf
RUN chmod g+x conf
RUN chown -R tomcat webapps/ work/ temp/ logs/
ENV CATALINA_HOME=/opt/tomcat
ENV JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
ENV CATALINA_PID=/opt/tomcat/temp/tomcat.pid
ENV CATALINA_BASE=/opt/tomcat
ENV CATALINA_OPTS='-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
EXPOSE 8080

RUN cp /boxfuse-sample-java-war-hello/target/hello-1.0.war /opt/tomcat/webapps/
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
