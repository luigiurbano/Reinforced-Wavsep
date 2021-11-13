FROM tomcat:9.0 

RUN apt-get update
RUN apt-get install -y curl netcat default-mysql-client

COPY . /
COPY wavsep.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["/docker/run.sh"]
