SHELL := /bin/bash

PUBDNS := $(shell terraform output public_dns)
KEY := ~/.ssh/keys/$(PUBDNS).key
KUBECONTEXT := aws-micro3



ssh:
	[ -f ~/.ssh/$(PUBDNS).key ] || { \
		terraform output ssh_private_key > $(KEY) && \
		chmod 600 $(KEY); }; \
	ssh ubuntu@$(PUBDNS) -i $(KEY)

destroy:
	terraform destroy
	rm -f $(KEY)

kubecontext:
	$(eval KUBETMP := $(shell mktemp))
	ssh ubuntu@$(PUBDNS) -i $(KEY) 'sudo kubectl config view --minify --flatten' | sed -e "s|server: https://.*:|server: https://$(PUBDNS):|" -e "s|minikube|$(KUBECONTEXT)|g" > $(KUBETMP)
	kubectl konfig import --save $(KUBETMP)
	@rm -f $(KUBETMP)