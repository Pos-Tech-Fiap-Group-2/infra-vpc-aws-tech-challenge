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
