variable "secret_name" {
  type = string
}

variable "secret_key_value" {
  type = map(string)
  description = "Secret Key Value pair"
  default = null
}

variable "tags" {
  type = map(string)
  default = {}
}