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
    xcode = list(object({
      version = string
      select  = bool
    }))
  })
  default = {
    brew = {
      casks = []
      packages = []
    }
    xcode = []
  }
}
