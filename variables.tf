variable "AWS_REGION" {
  type        = string
  description = "AWS region to be deployed to"
}

variable "AWS_ACCESS_KEY_ID" {
  type        = string
  description = "AWS access key"
}

variable "AWS_SECRET_ACCESS_KEY" {
  type        = string
  description = "AWS secret key"
}

variable "subnet_id_1" {
  type    = string
  default = "subnet-your_first_subnet_id"
}

variable "subnet_id_2" {
  type    = string
  default = "subnet-your_second_subnet_id"
}
 