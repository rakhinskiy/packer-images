SHELL := /bin/bash
BUILDPATH=$(CURDIR)
HOMEBREW_PREFIX ?= "/opt/homebrew"

.EXPORT_ALL_VARIABLES:

HOMEBREW_NO_AUTO_UPDATE=1
HOMEBREW_NO_INSTALL_CLEANUP=1

init:
		test -f ${HOMEBREW_PREFIX}/bin/tart   || ${HOMEBREW_PREFIX}/bin/brew install cirruslabs/cli/tart
		test -f ${HOMEBREW_PREFIX}/bin/packer || ${HOMEBREW_PREFIX}/bin/brew install hashicorp/tap/packer
		test -f ${HOMEBREW_PREFIX}/bin/xcodes || ${HOMEBREW_PREFIX}/bin/brew install xcodesorg/made/xcodes
		test -f ${HOMEBREW_PREFIX}/bin/aria2c || ${HOMEBREW_PREFIX}/bin/brew install aria2
		test -f ${HOMEBREW_PREFIX}/bin/jq     || ${HOMEBREW_PREFIX}/bin/brew install jq
		test -f ${HOMEBREW_PREFIX}/bin/rename || ${HOMEBREW_PREFIX}/bin/brew install rename
		@test -d ./runtime || mkdir -p ./runtime
		${HOMEBREW_PREFIX}/bin/packer init plugins.pkr.hcl

download:
		@${HOMEBREW_PREFIX}/bin/jq -c ".install.xcode[]" "variables.json" | ${HOMEBREW_PREFIX}/bin/jq -r .version | xargs -I {} bash -c "test -f $$(pwd)/runtime/Xcode-{}*.xip || /opt/homebrew/bin/xcodes download '{}' --directory $$(pwd)/runtime/"
		@rename 's/Xcode-(\d+).(\d+).(\d+)\+(.*).xip$$/Xcode-$$1.$$2.$$3.xip/' ./runtime/*
		@${HOMEBREW_PREFIX}/bin/jq -r -c '.install."vulkan-sdk"' "variables.json" | xargs -I {} bash -c "test -f $$(pwd)/runtime/vulkansdk-macos-{}.zip || curl -L --output ./runtime/vulkansdk-macos-{}.zip https://sdk.lunarg.com/sdk/download/{}/mac/vulkansdk-macos-{}.zip"
		@${HOMEBREW_PREFIX}/bin/jq -r -c '.install."swiftly"' "variables.json" | xargs -I {} bash -c "test -f $$(pwd)/runtime/swiftly-{}.pkg || curl -L --output ./runtime/swiftly-{}.pkg https://download.swift.org/swiftly/darwin/swiftly-{}.pkg"
build:
		@${HOMEBREW_PREFIX}/bin/packer build --var-file variables.json .

debug:
		@${HOMEBREW_PREFIX}/bin/packer build --on-error=abort --var-file variables.json .
