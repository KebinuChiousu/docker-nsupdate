MAINTAINER=meredithkm
TAG=nsupdate
VER=0.0.1

dev:
	docker build --build-arg BUILD=dev -t $(MAINTAINER)/$(TAG):$(VER)-dev --rm -f ./build/Dockerfile .
	docker tag $(MAINTAINER)/$(TAG):$(VER)-dev $(MAINTAINER)/$(TAG):dev

prod:
	docker build --build-arg BUILD=prod -t $(MAINTAINER)/$(TAG):$(VER) --rm -f ./build/docker/prod/Dockerfile .

tag_latest: 
	docker tag $(MAINTAINER)/$(TAG):$(VER) $(MAINTAINER)/$(TAG):latest

tag_stable:
	docker tag $(MAINTAINER)/$(TAG):$(VER) $(MAINTAINER)/$(TAG):stable

release:
	docker push $(MAINTAINER)/$(TAG):$(VER)
	docker push $(MAINTAINER)/$(TAG):$(VER)-dev
	docker push $(MAINTAINER)/$(TAG):latest
	@echo "*** Don't forget to create a tag by creating an official GitHub release."

test:
	docker run -it $(MAINTAINER)/$(TAG)-dev:latest /bin/bash
