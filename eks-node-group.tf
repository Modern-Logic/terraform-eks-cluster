data "aws_ami" "eks" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amazon-eks-node-1.22-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

module "shared_eks_launch_template" {
  source                      = "git@github.com:Modern-Logic/terraform-modules.git//simple/launch_template"
  environment                 = var.environment
  company_name                = var.company_name
  tags                        = var.tags
  template_name               = "eks"
  region                      = var.region
  associate_public_ip_address = false
  instance_type               = "t3.xlarge"
  key_name                    = "${var.app_name}-services-${var.environment}"
  ami                         = data.aws_ami.eks.image_id
  user_data                   = <<EOF
    #!/bin/bash
    set -o xtrace
    /etc/eks/bootstrap.sh ${var.environment}-eks
  EOF
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.environment}-eks"
  node_role_arn   = aws_iam_role.eks.arn
  subnet_ids      = local.private_subnet_ids

  launch_template {
    version = "$Latest"
    id      = module.shared_eks_launch_template.template_id
  }

  scaling_config {
    desired_size = 2
    max_size     = 5
    min_size     = 2
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_eks_cluster.main
  ]
}
