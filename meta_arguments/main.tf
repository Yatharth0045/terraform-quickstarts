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
