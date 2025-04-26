variable "application_name" {
  type = string
}
variable "environment_name" {
  type = string
}
variable "primary_location" {
  type = string
}
variable "base_address_space" {
  type = string
}
variable "additional_regions" {
  type = map(string)
  default = {}
}
variable "vpn_address_space" {
  type = string
}
variable "dns_address_space" {
  type = string
}
variable "additional_tags" {
  type = map(string)
  default = {}
}