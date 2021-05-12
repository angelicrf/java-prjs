FROM tomcat:latest
#FROM ubuntu:latest
#WORKDIR /usr/app
#RUN apt-get update -y
#RUN apt-get install -y openjdk-8-jdk
#RUN apt-get install -y wget tar curl
#RUN apt-get update -y
#RUN groupadd tomcat
#RUN useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
#RUN cd /tmp
#RUN curl -O https://downloads.apache.org/tomcat/tomcat-9/v9.0.45/bin/apache-tomcat-9.0.45.tar.gz
#RUN mkdir /opt/tomcat
#RUN tar xzvf apache-tomcat-9*tar.gz -C /opt/tomcat --strip-components=1
#RUN cd /opt/tomcat
#RUN chgrp -R tomcat /opt/tomcat
#RUN chmod -R g+r /opt/tomcat/conf
#RUN chmod g+x /opt/tomcat/conf
#RUN chown -R tomcat /opt/tomcat/webapps /opt/tomcat/work /opt/tomcat/temp /opt/tomcat/logs
#COPY . /usr/app/
COPY  ./target/web-app-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
#command to run: docker run --rm -it -p 8080:8080 angelique/myjava_app
#open this link on: http://localhost:8080/web-app-1.0-SNAPSHOT/
#CMD ["/opt/tomcat/bin/catalina.sh","run"]