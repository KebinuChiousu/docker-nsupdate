MAINTAINER=meredithkm
TAG=nsupdate
VER=0.0.1

build_prod:
	docker build -t $(MAINTAINER)/$(TAG):$(VER) --rm -f ./build/docker/prod/Dockerfile .

dev:
	docker build -t $(MAINTAINER)/$(TAG):$(VER)-dev --rm -f ./build/docker/dev/Dockerfile .
	docker tag $(MAINTAINER)/$(TAG):$(VER)-dev $(MAINTAINER)/$(TAG):dev
	docker build -t $(MAINTAINER)/$(TAG)-dev:latest --rm -f ./docker/dev/Dockerfile .

prod:
	docker build -t $(MAINTAINER)/$(TAG):prod --rm -f ./docker/prod/Dockerfile .

tag_latest: 
	docker tag $(MAINTAINER)/$(TAG):$(VER) $(MAINTAINER)/$(TAG):latest

release:
	docker push $(MAINTAINER)/$(TAG):$(VER)
	docker push $(MAINTAINER)/$(TAG):$(VER)-dev
	docker push $(MAINTAINER)/$(TAG):latest
	@echo "*** Don't forget to create a tag by creating an official GitHub release."

test:
	docker run -it $(MAINTAINER)/$(TAG)-dev:latest /bin/bash
