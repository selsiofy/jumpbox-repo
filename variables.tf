variable "azure_bastion_vnet" {
  type        = string 
}

variable "resource_group_name" {
  type        = string
  description = "Azure resource group name"
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
}

variable "vm_name" {
  type        = string
  default     = "vm-01"
  description = "virtual machine name"
}
variable "comp_name" {
  type        = string
  default     = "org-name"
  description = "virtual machine host name"
}
variable "comp_usr_name" {
  type        = string
  default     = "bastion"
  description = "virtual machine user name"
}
variable "comp_usr_pass" {
  type        = string
  default     = "bastionpass"
  description = "virtual machine user password"
}

//extention vars
variable "extention_name" {
  type        = string
  default     = "AADLoginForLinux"
  description = "virtual machine etention name"
}
