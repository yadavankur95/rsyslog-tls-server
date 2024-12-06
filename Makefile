.PHONY: image push test

push: image
	docker push yadavankur95/rsyslog-tls-server:latest

image:
	docker build . -t yadavankur95/rsyslog-tls-server:latest

helm:
	helm package charts/rsyslog -d build