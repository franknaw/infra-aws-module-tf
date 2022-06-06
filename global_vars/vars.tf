variable "assume_role_partition" {
  type = map(string)
  default = {
    "com" = "aws"
    "gov"  = "aws-us-gov"
  }
  description = "Partition to be used in ARN"
}

variable "role_partition_ids" {
  type = map(string)
  default = {
    "dev" : "some account number"
  }
}

variable "role_part_id" {
  type = map(string)
  default = {
    "dev" : "dev"
  }
  description = "Set the environment role partition Id"
}

variable "role_part" {
  default     = "com"
  description = "Set the environment role partition"
}

variable "region" {
  type = map(string)
  default = {
    "com-west" = "us-west-1"
    "com-east" = "us-east-1"
  }
  description = "Region to be used"
}


variable "tags" {
  type = map(string)
  default = {
    "gateway_name" : "GATEWAY"
    "gateway_deployment" : "GATEWAY"
    "range_name" : "RANGE"
    "range_deployment" : "RANGE"
    "guac_name" : "GUAC"
    "guac_deployment" : "GUAC"
    "subsystem" : "networking"
  }
}

variable "cidr_block_vpc" {
  type = map(map(string))
  default = {
    "dev" : {
      "vpn" : "10.10.0.0/22"
      "gateway" : "172.16.0.0/22"
      "range" : "172.16.16.0/22"
      "guac" : "172.16.32.0/22"
    }
  }
}

variable "cidr_block_sub" {
  type = map(map(list(string)))
  default = {
    "dev" : {
      "vpn_private" : ["10.10.0.0/24", "10.10.1.0/24"]
      "vpn_public" : ["10.10.2.0/24"]
      "gateway_private" : ["172.16.0.0/24", "172.16.1.0/24"]
      "gateway_public" : ["172.16.2.0/24", "172.16.3.0/24"]
      "range_private" : ["172.16.16.0/24", "172.16.17.0/24"]
      "range_public" : ["172.16.18.0/24"]
      "guac_private" : ["172.16.32.0/24", "172.16.33.0/24"]
      "guac_public" : ["172.16.34.0/24"]
    }
  }
}

variable "ip_acl" {
  type = list(string)
  default = [
    "72.83.21.25/32"] # my IP
}

variable "route_domain" {
  type    = string
  default = "infra-dev.local"
}

variable "alb_base_url" {
  type = map(string)
  default = {
    "dev" : "https://infra-fnaw.com"
  }
  description = "ALB Base URL"
}

variable "environment" {
  type = map(string)
  default = {
    "dev" : "dev"
  }
  description = "Set the environment for provisioning"
}

variable "ecr_policy" {
  default = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "ECR Repository Policy",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:GetRepositoryPolicy",
                "ecr:ListImages",
                "ecr:DeleteRepository",
                "ecr:BatchDeleteImage",
                "ecr:SetRepositoryPolicy",
                "ecr:DeleteRepositoryPolicy"
            ]
        }
    ]
}
EOF
}

# Legacy, does not need to include CRMS API's
variable "api_services" {
  type = map(string)
  default = {
    "guac-app" : "guacamole-client"
    "guac-d" : "guacamole-server"
    "landing-page" : "landing-page"
  }
}

####################################################
############## Versions for ONLY CRMS ##############
####################################################
variable "cvle_version" {
  type = map(map(map(string)))
  default = {
    "1.0.0" : {
      "range-micro-1" : {
        "version" : "0.0.2",
        "api" : "range-micro-1"
      },
      "range-micro-2" : {
        "version" : "0.0.2",
        "api" : "range-micro-2"
      }
    }
  }
}

