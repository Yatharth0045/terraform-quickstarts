resource "local_file" "file_count" {
  count = length(var.filename)
  filename = "a-${var.filename[count.index]}.txt"
  content = "This is my file"
}

resource "local_file" "file_loop" {
  for_each = toset(var.filename)
  filename = "b-${each.key}.txt"
  content = "This is my file"
}

output "output_count_file" {
  value = local_file.file_count.*.filename
}

output "output_loop_file_list" {
  value = [
    for file in local_file.file_loop : file.filename
  ]
}

output "output_loop_file_map" {
  value = {
    for f, file in local_file.file_loop : f => file.filename
  }
}

variable "filename" {
  default = [
    "file1",
    "file2",
    "file3"
  ]
}