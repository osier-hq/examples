variable "env_name" { type = string }
variable "greeting" {
  type      = string
  sensitive = true
  default   = "hello"
}

resource "random_pet" "name" {
  length = 2
  prefix = var.env_name
}

output "pet" { value = random_pet.name.id }
