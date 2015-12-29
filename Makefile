REPO=mattf

.PHONY: build clean push create destroy

build:
	docker build -t openshift-spark .

clean:
	docker rmi openshift-spark

push: build
	docker tag -f openshift-spark $(REPO)/openshift-spark
	docker push $(REPO)/openshift-spark

create: push
	sed "s,_REPO_,$(REPO)," template.yaml.template > template.yaml
	oc process -f template.yaml > template.active
	oc create -f template.active

destroy:
	oc delete -f template.active
