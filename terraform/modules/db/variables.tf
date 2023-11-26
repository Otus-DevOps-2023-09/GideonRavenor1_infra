variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-base-1701005591"
}

variable cpu_count {
  description = "Number of cpu core"
  default     = 2
}

variable mem_size {
  description = "Memory size"
  default     = 2
}

variable subnet_id {
  description = "Subnets for modules"
}
