MAINTAINER=meredithkm
TAG=nsupdate
VER=0.0.1
UWSGI_UID=$(shell id -u www-data)
UWSGI_GID=$(shell id -g www-data)

all: dev prod test

build: dev prod

dev:
	docker build --build-arg BUILD=dev --build-arg uwsgi_uid=$(UWSGI_UID) --build-arg uwsgi_gid=$(UWSGI_GID) -t $(MAINTAINER)/$(TAG):$(VER)-dev --rm -f ./build/Dockerfile .
	docker tag $(MAINTAINER)/$(TAG):$(VER)-dev $(MAINTAINER)/$(TAG):dev

prod:
	docker build --build-arg BUILD=prod --build-arg uwsgi_uid=$(UWSGI_UID) --build-arg uwsgi_gid=$(UWSGI_GID) -t $(MAINTAINER)/$(TAG):$(VER) --rm -f ./build/Dockerfile .
	docker tag $(MAINTAINER)/$(TAG):$(VER) $(MAINTAINER)/$(TAG):prod

release:
	docker push $(MAINTAINER)/$(TAG):$(VER)
	docker push $(MAINTAINER)/$(TAG):$(VER)-dev
	docker push $(MAINTAINER)/$(TAG):prod
	docker push $(MAINTAINER)/$(TAG):dev
	@echo "*** Don't forget to create a tag by creating an official GitHub release."

release_latest:
	docker tag $(MAINTAINER)/$(TAG):$(VER) $(MAINTAINER)/$(TAG):latest
	docker push $(MAINTAINER)/$(TAG):latest

release_stable:
	docker tag $(MAINTAINER)/$(TAG):$(VER) $(MAINTAINER)/$(TAG):stable
	docker push $(MAINTAINER)/$(TAG):stable

test:
	docker run --name $(TAG)-test-dev -d $(MAINTAINER)/$(TAG):dev
	docker run --name $(TAG)-test-prod -d $(MAINTAINER)/$(TAG):prod

clean:
	docker rm -f -v $(TAG)-test-dev
	docker rm -f -v $(TAG)-test-prod
