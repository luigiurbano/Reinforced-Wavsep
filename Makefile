COMPOSE = docker-compose
MVN = mvn
BUILD=docker build -t

IMAGE = nsunina/wavsep:v1.8.1
DB_IMAGE=nsunina/wavsep-db:v1.8

build:
	$(BUILD) $(IMAGE) .
	$(BUILD) $(DB_IMAGE) -f Dockerfile.sql .


push: build
	docker push $(IMAGE)
	docker push $(DB_IMAGE)

compose-build:
	$(COMPOSE) build

compose-up: build
	$(COMPOSE) up

run: 
	docker network create wavsep-net
	docker run --rm -d --net wavsep-net -d  -p 18080:8080 --name wavsep $(IMAGE)
	docker run --rm -d --net wavsep-net --name wavsepdb $(DB_IMAGE) 

rm:
	docker rm -f wavsep
	docker rm -f wavsepdb
	docker network rm wavsep-net

down: 
	$(COMPOSE) down
