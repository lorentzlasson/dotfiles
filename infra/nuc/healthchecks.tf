provider "healthchecksio" {
  api_key = var.healthchecksio_api_key
}

data "healthchecksio_channel" "email" {
  kind = "email"
}

resource "healthchecksio_check" "nuc" {
  name = "nuc"
  desc = "nuc pings this every 5 minutes; silence means the box or its network is gone"

  timeout = 300
  grace   = 600

  channels = [data.healthchecksio_channel.email.id]
}
