# Two DNS records for an Osier walkthrough.
#
# The addresses come from 192.0.2.0/24 (TEST-NET-1, RFC 5737). That range is
# reserved for documentation, so no real server answers and no traffic moves.
# A change to a DNS record still counts as a critical resource in Osier's risk
# score, so every plan here waits for a person to approve it.

resource "cloudflare_dns_record" "api" {
  zone_id = var.zone_id
  name    = "api.demo.${var.zone_name}"
  type    = "A"
  content = "192.0.2.20"
  ttl     = 300
  proxied = false
  comment = "Osier demo (osier-hq/examples dns-demo)"
}

resource "cloudflare_dns_record" "app" {
  zone_id = var.zone_id
  name    = "app.demo.${var.zone_name}"
  type    = "CNAME"
  content = cloudflare_dns_record.api.name
  ttl     = 300
  proxied = false
  comment = "Osier demo (osier-hq/examples dns-demo)"
}

output "api_record" {
  value = "${cloudflare_dns_record.api.name} -> ${cloudflare_dns_record.api.content}"
}
