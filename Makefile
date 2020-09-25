ACT_EVENT = workflow_dispatch
ACT_PLATFORM = ubuntu-latest=nektos/act-environments-ubuntu:18.04

.PHONY: gha.workflow_dispatch.dryrun
gha.workflow_dispatch.dryrun: gha.init-github_token
	@which act > /dev/null 2>&1 || brew install nektos/tap/act
	@act $(ACT_EVENT) \
		--platform=$(ACT_PLATFORM) \
		-s GITHUB_TOKEN=$(GITHUB_TOKEN)

.PHONY: gha.init-github_token
gha.init-github_token:
ifndef GITHUB_TOKEN
	$(eval GITHUB_TOKEN = $(shell \
	  read -p $$'\e[33mPlease enter the GITHUB_TOKEN\e[0m: ' val; \
	  echo $${val} \
	))
endif

