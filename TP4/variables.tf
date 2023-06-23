variable "location" {
  description = "Location of the VM"
  type        = string
  default     = "france central"
}

variable "resource_group" {
  description = "Resource group name"
  type        = string
  default     = "ADDA84-CTP"
}

variable "subscription_id" {
  description = "The subscription id"
  type        = string
  default     = "765266c6-9a23-4638-af32-dd1e32613047"
}

variable "network" {
  description = "Network name"
  type        = string
  default     = "network-tp4"
}

variable "subnet" {
  description = "Subnet name"
  type        = string
  default     = "internal"
}

variable "admin" {
  description = "admin name"
  type        = string
  default     = "devops"
}
