variable "ec2_instance_profile" {
  type        = string
  description = "IAM instance profile for EC2"
  default     = null
}
variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}