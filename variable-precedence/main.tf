resource "random_id" "my_id" {
  byte_length = var.byte_length
}

variable "byte_length" {
  type    = number
  default = 4
}

output "id" {
  value = random_id.my_id.id
}

output "id_length" {
  value = random_id.my_id.byte_length
}