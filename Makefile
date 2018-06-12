MAINTAINER=meredithkm
TAG=nsupdate
VERSION=0.0.1

dev:
	docker build -t $(MAINTAINER)/$(TAG):$(VERSION)-dev --rm -f ./build/docker/dev/Dockerfile .

prod:
	docker build -t $(MAINTAINER)/$(TAG):$(VERSION) --rm -f ./docker/docker/prod/Dockerfile .

tag_latest: 
	docker tag $(MAINTAINER)/$(TAG):$(VERSION) $(MAINTAINER)/$(TAG):latest

release:
	docker push $(MAINTAINER)/$(TAG):$(VERSION)
	docker push $(MAINTAINER)/$(TAG):$(VERSION)-dev
	docker push $(MAINTAINER)/$(TAG):latest
	@echo "*** Don't forget to create a tag by creating an official GitHub release."

test:
	docker run -it $(MAINTAINER)/$(TAG):$(VERSION)-dev /bin/bash
