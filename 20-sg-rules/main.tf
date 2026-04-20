resource "aws_security_group_rule" "bastion_internet" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  #cidr_blocks       = ["0.0.0.0/0"]
  cidr_blocks =    [local.my_ip]
  # which SG you are creating this rule
  security_group_id = local.bastion_sg_id
}

# MongoDB
resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.mongodb_sg_id
}



#redis
#redis accepting the connection form bastion on port no:22
resource "aws_security_group_rule" "redis_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.redis_sg_id
}



#mysql server accepting the connection from bastion on port 22
resource "aws_security_group_rule" "mysql_bastion" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.mysql_sg_id
}

/* resource "aws_security_group_rule" "mysql_eks_node" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = local.eks_node_sg_id
  security_group_id = local.mysql_sg_id
}
 */
#Rabbitmq
resource "aws_security_group_rule" "rabbitmq_bastion" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.rabbitmq_sg_id

}


# Frontend ALB
resource "aws_security_group_rule" "ingress_alb_public" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = local.ingress_alb_sg_id
}
#open VPN
resource "aws_security_group_rule" "openvpn_public_443" {
 type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = local.openvpn_sg_id
}
#Admin UI openvpn
resource "aws_security_group_rule" "openvpn_public_943" {
 type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  # Where traffic is coming from
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = local.openvpn_sg_id
}

resource "aws_security_group_rule" "bastion_openvpn" {
 type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = local.openvpn_sg_id
  security_group_id = local.bastion_sg_id
}

resource "aws_security_group_rule" "eks_control_plane_bastion" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.eks_control_plane_sg_id
}

resource "aws_security_group_rule" "eks_node_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  # Where traffic is coming from
  source_security_group_id = local.bastion_sg_id
  security_group_id = local.eks_node_sg_id
}

resource "aws_security_group_rule" "eks_control_plane_eks_node" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1" # all traffic
  # Where traffic is coming from
  source_security_group_id = local.eks_node_sg_id
  security_group_id = local.eks_control_plane_sg_id
}

resource "aws_security_group_rule" "eks_node_eks_control_plane" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1" # all traffic
  # Where traffic is coming from
  source_security_group_id = local.eks_control_plane_sg_id
  security_group_id = local.eks_node_sg_id
}

resource "aws_security_group_rule" "eks_node_vpc_cidr" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1" # all traffic
  # VPC CIDR
  cidr_blocks = ["10.0.0.0/16"]
  security_group_id = local.eks_node_sg_id
}