resource "aws_db_instance" "rds-postgres" {
  instance_class          = var.db_instance
  engine                  = "postgresql"
  engine_version          = "12.4-R1"
  multi_az                = true
  storage_type            = "gp2"
  allocated_storage       = 20
  name                    = "${var.environment}-${var.vpc_name}-rds-postgres"
  username                = "postgres"
  password                = "postgresadmin"
  apply_immediately       = "true"
  backup_retention_period = 10
  backup_window           = "09:46-10:16"
  db_subnet_group_name    = aws_db_subnet_group.rds-subnet.name
#  vpc_security_group_ids  = ["${aws_security_group.my-rds-sg.id}"]
}

resource "aws_db_subnet_group" "rds-subnet" {
  name       = "rds-subnet"
  subnet_ids = [var.rds_subnet1, var.rds_subnet2]
}