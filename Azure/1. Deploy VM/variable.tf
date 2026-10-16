# Variables for VM deployment and state management

variable "rg_name" {
  type        = string
  description = "The name of the resource group in which to create the resources."
  default     = "anthony-ughanze-portfolio"
}

variable "sg_accnt_name" {
  type = string
  default = "portfoliostorageaccount"
}

variable "cont_name" {
  type = string
  default = "statefile"
}

variable "location" {
  type        = string
  description = "The Azure region in which to create the resources."
  default     = "eastus"
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network."
  default     = "Houston-vnet"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet."
  default     = "office-subnet"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "The address space for the virtual network."
  default     = ["10.200.0.0/16"]
}

variable "subnet_address_prefix" {
  type        = list(string)
  description = "The address prefix for the subnet."
  default     = ["10.200.50.0/24"]
}

variable "vm_name" {
  description = "Name of the Azure virtual machine"
  type        = string
  default     = "vm-demo-linux"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
  default     = "P@ssw0rd1234!"
}