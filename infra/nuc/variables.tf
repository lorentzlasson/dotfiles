variable "cloudflare_api_token" {
  type      = string
  sensitive = true
}

variable "cloudflare_account_id" {
  type = string
}

variable "cloudflare_zone_id" {
  type = string
}

variable "access_email" {
  type      = string
  sensitive = true
}

variable "healthchecksio_api_key" {
  type      = string
  sensitive = true
}
