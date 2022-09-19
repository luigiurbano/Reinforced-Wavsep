COMPOSE = docker-compose
MVN = mvn
IMAGE = nsunina/wavsep:v1.8
build:
	$(MVN) package
	$(COMPOSE) build

up: build
	$(COMPOSE) up

push: 
	docker build -t $(IMAGE) .
	docker push $(IMAGE)

down: 
	$(COMPOSE) down
