terraform {
  required_version = ">= 1.6"
  required_providers {
    cloudflare = { source = "cloudflare/cloudflare", version = "~> 5.0" }
  }
}

# Reads CLOUDFLARE_API_TOKEN from the environment. In Osier, set it as a
# sensitive stack variable.
provider "cloudflare" {}
