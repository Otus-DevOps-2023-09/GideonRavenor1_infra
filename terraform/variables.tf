variable "cloud_id" {
  description = "Cloud"
}
variable "folder_id" {
  description = "Folder"
}
variable "zone" {
  description = "Zone"
  default     = "ru-central1-a"
}
variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}

variable "subnet_id" {
  description = "Subnet"
}
variable "service_account_key_file" {
  description = "key .json"
}

variable "private_key_path" {
  description = "Path to the private key used for ssh access"
}

variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "reddit-app-base-1701005795"
}

variable "db_disk_image" {
  description = "Disk image for reddit db"
  default     = "reddit-db-base-1701005591"
}

variable "cpu_count" {
  description = "Number of cpu core"
  default     = 2
}

variable "mem_size" {
  description = "Memory size"
  default     = 2
}

variable "bucket_name" {
  description = "Name of bucket"
}
variable "access_key" {
  description = "access key"
}
variable "secret_key" {
  description = "secret key"
}
