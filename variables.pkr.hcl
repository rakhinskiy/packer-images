variable "account" {
  type = object({
    description = string
    username    = string
    password    = string
  })
}

variable "image" {
  type = object({
    name    = string
    cpu     = number
    ram     = number
    disk    = number
    version = string
  })
}

variable "install" {
  type = object({
    brew = object({
      casks    = list(string)
      packages = list(string)
    })
    swift = string
    xcode = list(object({
      version = string
      select  = bool
    }))
    xcode-platforms = list(object({
      platform = string
      version  = string
    }))
    vulkan-sdk = string
  })
  default = {
    brew = {
      casks = []
      packages = []
    }
    swift: "6.1.2"
    xcode = []
    xcode-platforms = []
    vulkan-sdk = "1.4.313.1"
  }
}
