SHELL := /bin/bash
BUILDPATH=$(CURDIR)
HOMEBREW ?= "/opt/homebrew/bin/"

.EXPORT_ALL_VARIABLES:

HOMEBREW_NO_AUTO_UPDATE=1
HOMEBREW_NO_INSTALL_CLEANUP=1

init:
		@${HOMEBREW}/brew list | grep -q ^tart$   || ${HOMEBREW}/brew install cirruslabs/cli/tart
		@${HOMEBREW}/brew list | grep -q ^packer$ || ${HOMEBREW}/brew install hashicorp/tap/packer
		@${HOMEBREW}/brew list | grep -q ^xcodes$ || ${HOMEBREW}/brew install xcodesorg/made/xcodes
		@${HOMEBREW}/brew list | grep -q ^aria2$  || ${HOMEBREW}/brew install aria2
		@${HOMEBREW}/brew list | grep -q ^jq$     || ${HOMEBREW}/brew install jq
		@${HOMEBREW}/brew list | grep -q ^rename$ || ${HOMEBREW}/brew install rename
		@test -d runtime || mkdir -p runtime
		@${HOMEBREW}/packer init plugins.pkr.hcl

download:
		@${HOMEBREW}/jq -c ".install.xcode[]" "variables.json" | ${HOMEBREW}/jq -r .version | xargs -I {} bash -c "test -f $$(pwd)/runtime/Xcode-{}*.xip || /opt/homebrew/bin/xcodes download '{}' --directory $$(pwd)/runtime/"
		@rename 's/Xcode-(\d+).(\d+).(\d+)\+(.*).xip$$/Xcode-$$1.$$2.$$3.xip/' ./runtime/*

build:
		@/opt/homebrew/bin/packer build --var-file variables.json .

debug:
		@/opt/homebrew/bin/packer build --on-error=abort --var-file variables.json .
