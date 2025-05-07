variable "version" {
    type = string
    default = "6.5.6"
}

variable "domain" {
  type = string
}
variable "zone_name" {
  type = string
}

variable "external_dns_role_name" {
  type = string
}

variable "cluster_name" {
    type = string
}