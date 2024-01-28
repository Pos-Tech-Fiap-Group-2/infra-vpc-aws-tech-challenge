variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "lb_name" {
  default = "tech-challenge-lb"

}

variable "lb_tg_name" {
  default = "tech-challenge-lb-tg"

}

variable "alb_sg_name" {
  default = "tech-challenge-alb-sg"

}

variable "cidr_blocks" {
  description = "Allow traffic from Cidr blocks, override for internal Cidr blocks"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "nlb_enabled" {
  description = "Enable NLB"
  type        = bool
  default     = true
}
