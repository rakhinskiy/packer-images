#### Build

```shell
# Install required packages and packer plugins
make init  # Run once

# Only once for apple id two-factor auth
export XCODES_USERNAME="..."
export XCODES_PASSWORD="..."
xcodes download '16.2.0' --directory "$(pwd)/runtime/"

nano variables.json

# Run once or if vulkan / xcode versions changed
make download

make build

# If build failed
make debug
```

#### Run

```shell
# tart run {{ image.name }}:{{ image.version }} | from variables.json
tart run ci:sequoia
```

#### XCode

[Releases](https://xcodereleases.com/?scope=release)