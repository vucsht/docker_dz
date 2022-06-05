FROM ubuntu:20.04
RUN apt update
RUN apt install git -y
ENV TZ=Europe/Moscow
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt install default-jdk -y
RUN apt install maven -y
RUN apt install tomcat9 -y
EXPOSE 8080
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR boxfuse-sample-java-war-hello/
RUN mvn package
RUN cp target/hello-1.0.war /var/lib/tomcat9/webapps/
WORKDIR /usr/local/tomcat
ENV CATALINA_HOME=/usr/share/tomcat9
ENV JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
ENV PATH=/usr/local/tomcat/bin:/usr/local/openjdk-11/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
CMD ["/usr/share/tomcat9/bin/catalina.sh", "run"]
