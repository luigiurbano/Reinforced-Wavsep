FROM mysql:8.0.32


COPY db/wavsep.sql /docker-entrypoint-initdb.d/wavsep.sql

ENV MYSQL_ROOT_PASSWORD=pass
ENV MYSQL_ROOT_HOST=%
ENV MYSQL_USER=wavsep
ENV MYSQL_PASSWORD=wavsepPass782
ENV MYSQL_DATABASE=wavsepDB   


