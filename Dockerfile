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
RUN cd boxfuse-sample-java-war-hello/
RUN ls -la
#RUN mvn package
#RUN cd target
#RUN cp hello-1.0.war /var/lib/tomcat9/webapps/
CMD ["/bin/bash"]
