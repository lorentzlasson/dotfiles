terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "lorentz" {
  account_id = var.cloudflare_account_id
  name       = "lorentz"
  config_src = "cloudflare"
}

data "cloudflare_zero_trust_tunnel_cloudflared_token" "lorentz" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.lorentz.id
}

resource "cloudflare_dns_record" "grafana" {
  zone_id = var.cloudflare_zone_id
  name    = "grafana.lorentz.casa"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.lorentz.id}.cfargotunnel.com"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_dns_record" "www" {
  zone_id = var.cloudflare_zone_id
  name    = "www.lorentz.casa"
  content = "${cloudflare_zero_trust_tunnel_cloudflared.lorentz.id}.cfargotunnel.com"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}
