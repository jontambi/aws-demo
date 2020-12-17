resource "aws_db_instance" "rds-postgres" {
#  count                     = 2
  instance_class            = var.db_instance
  engine                    = "postgres"
  engine_version            = "12.4"
#  endpoint                = "terraform-20201217064642701300000001.cm6perbt44qh.us-east-1.rds.amazonaws.com"
  identifier                = var.identifier
  multi_az                  = var.multi_az
  storage_type              = "gp2"
  allocated_storage         = 20
  name                      = var.name
  username                  = "postgres"
  password                  = "postgresadmin"
  skip_final_snapshot       = true
  apply_immediately         = true
#  availability_zone         = element(var.azs, count.index)
#  final_snapshot_identifier = "demosre" 
#  backup_retention_period   = 1
#  backup_window             = "09:46-10:16"
  db_subnet_group_name      = aws_db_subnet_group.rds-subnet.name
  vpc_security_group_ids    = [aws_security_group.rds-sg.id]
}

resource "aws_db_subnet_group" "rds-subnet" {
  name       = "rds-subnet"
  subnet_ids = [var.rds_subnet1, var.rds_subnet2]
}

resource "aws_security_group" "rds-sg" {
  name   = "rds-sg"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "rds-sg-rule" {
  from_port         = 5432
  protocol          = "tcp"
  security_group_id = aws_security_group.rds-sg.id
  to_port           = 5432
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "outbound_rule" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.rds-sg.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}