resource "aws_security_group" "sg" {
  name                   = var.security_group_name
  description            = var.description
  vpc_id                 = var.vpc_id
  tags = merge(
    {
      Name = var.security_group_name
    },
     var.tags  # This will be an empty map if not specified
  )
}

#Ingress rules with CIDR_blocks and prefix Lists without Source Security groups ids and self
resource "aws_security_group_rule" "ingress_rules" {
  count             = length(var.ingress_rules)>0?length(var.ingress_rules) : 0
  security_group_id = aws_security_group.sg.id
  type              = "ingress"
  cidr_blocks       = try(var.ingress_rules[count.index]["cidr_blocks"], null) 
  description       = var.ingress_rules[count.index]["description"]
  from_port         = var.ingress_rules[count.index]["from_port"]
  to_port           = var.ingress_rules[count.index]["to_port"]
  protocol          = var.ingress_rules[count.index]["protocol"]
}

#Ingress rules with Source Security group ids without CIDR_blocks and self
resource "aws_security_group_rule" "ingress_rules_with_source_security_group_ids" {
  count                    = length(var.ingress_rules_with_source_security_group_ids)>0?length(var.ingress_rules_with_source_security_group_ids) : 0
  security_group_id        = aws_security_group.sg.id
  type                     = "ingress"
  source_security_group_id = var.ingress_rules_with_source_security_group_ids[count.index]["source_security_group_id"]
  description              = var.ingress_rules_with_source_security_group_ids[count.index]["description"]
  from_port                = var.ingress_rules_with_source_security_group_ids[count.index]["from_port"]
  to_port                  = var.ingress_rules_with_source_security_group_ids[count.index]["to_port"]
  protocol                 = var.ingress_rules_with_source_security_group_ids[count.index]["protocol"]
}


#Egress rules with CIDR_blocks and prefix Lists without Source Security groups ids and self
resource "aws_security_group_rule" "egress_rules" {
  count             = length(var.egress_rules)>0?length(var.egress_rules) : 0
  security_group_id = aws_security_group.sg.id
  type              = "egress"
  cidr_blocks       = try(var.egress_rules[count.index]["cidr_blocks"], null)
  description       = var.egress_rules[count.index]["description"]
  from_port         = var.egress_rules[count.index]["from_port"]
  to_port           = var.egress_rules[count.index]["to_port"]
  protocol          = var.egress_rules[count.index]["protocol"]
}