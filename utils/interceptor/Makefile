build:
	docker build -t nsunina/interceptor .
run: build
	docker run -v `pwd`:/app --rm -it --net container:reinforced-wavsep_wavsep_1 nsunina/interceptor "echo start" "echo stop"
	