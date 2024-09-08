## Count
resource "local_file" "file" {
  count    = length(var.filename)
  filename = "./files/${var.filename[count.index]}"
  content  = "This is my file ${count.index}\n"
}

variable "filename" {
  type = list(string)
  default = [
    "file1.txt",
    "file2.txt",
    "file3.txt"
  ]
}

output "filenames" {
  value     = local_file.file
  sensitive = true
}

## For_each
resource "local_file" "file_new" {
  for_each = toset(var.filename_set)
  filename = "./files/${each.value}"
  content  = "This is my file name ${each.value}\n"
}

variable "filename_set" {
  type = list(string)
  default = [
    "fileA.txt",
    "fileB.txt"
  ]
}

output "filenames_set" {
  value     = local_file.file_new
  sensitive = true
}
