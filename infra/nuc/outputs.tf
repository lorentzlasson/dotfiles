output "tunnel_token" {
  value     = data.cloudflare_zero_trust_tunnel_cloudflared_token.lorentz.token
  sensitive = true
}

output "tunnel_id" {
  value = cloudflare_zero_trust_tunnel_cloudflared.lorentz.id
}

output "healthchecks_ping_url" {
  value     = healthchecksio_check.nuc.ping_url
  sensitive = true
}
