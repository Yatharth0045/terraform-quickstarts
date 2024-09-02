resource "local_file" "my_file" {
  filename = "./pets.txt"
  content  = "Sample file containing id: ${random_id.my_id.id}"
}

resource "random_id" "my_id" {
  byte_length = var.byte_length
}

variable "byte_length" {
  type    = number
  default = 8
}

output "id" {
  value = random_id.my_id.id
}

output "id_length" {
  value = random_id.my_id.byte_length
}
