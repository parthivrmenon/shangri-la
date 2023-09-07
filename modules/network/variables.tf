variable "cidr_block" {
  description = "CIDR block to configure for VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "primary_subnet_cidr_block" {
  description = "CIDR block to configure primary subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "secondary_subnet_cidr_block" {
  description = "CIDR block to configure secondary subnet"
  type        = string
  default     = "10.0.2.0/24"
}