FROM maven  AS build
COPY . /app
WORKDIR /app
RUN mvn package 

FROM tomcat:8.5.84-jdk8-corretto
COPY --from=build /app/target/wavsep-enhancement-1.8-SNAPSHOT.war /usr/local/tomcat/webapps/wavsep.war
