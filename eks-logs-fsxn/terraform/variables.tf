variable "kubernetes_version" {
  #default     = 1.29
  default     = "1.30"
  description = "kubernetes version"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "default CIDR range of the VPC"
}
variable "aws_region" {
  nullable    = true
  #default     = "eu-west-1"
  default     = "ap-northeast-2"  
  description = "aws region"
}

variable "fsxame" {
  #default     = "eksfs"
  default     = "eks-netapp-fs"  
  description = "default fsx name"
}

variable "fsx_admin_password" {
  default     = "Netapp1!"
  description = "default fsx filesystem admin password"
}

variable "fsxn_addon_version" {
  #default     = "v24.2.0-eksbuild.1"
  default     = "v24.10.0-eksbuild.1"  
  description = "fsx csi addon version"
}

variable "profile" {
  description = "Profile for AWS CLI, kubectl" # aws profile 따로 지정 안하고 사용하시면 default로 기재 바랍니다.
  type        = string
  default     = "eks-offer"
}