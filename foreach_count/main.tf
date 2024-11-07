module "file" {
    source = "./modules/local_file"
    filename = var.filename
}

output "count_file" {
  value = module.file.output_count_file
}

output "loop_file_list" {
  value = module.file.output_loop_file_list
}

output "loop_file_map" {
  value = module.file.output_loop_file_map
}

variable "filename" {
  default = [
    "my-file-1",
    "my-file-2",
    "my-file-3"
  ]
}
