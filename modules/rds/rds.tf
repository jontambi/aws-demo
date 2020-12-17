resource "aws_db_instance" "rds-postgres" {
  count                     = 2
  instance_class            = var.db_instance
  engine                    = "postgres"
  engine_version            = "12.4"
#  endpoint                = "terraform-20201217064642701300000001.cm6perbt44qh.us-east-1.rds.amazonaws.com"
  identifier                = var.identifier 
#  multi_az                = var.multi_az
  storage_type              = "gp2"
  allocated_storage         = 20
  name                      = var.name
  username                  = "postgres"
  password                  = "postgresadmin"
#  skip_final_snapshot       = false 
#  apply_immediately         = true
  availability_zone         = element(var.azs, count.index)
#  final_snapshot_identifier = "demosre" 
#  backup_retention_period   = 1
#  backup_window             = "09:46-10:16"
  db_subnet_group_name      = aws_db_subnet_group.rds-subnet.name
#  vpc_security_group_ids  = ["${aws_security_group.my-rds-sg.id}"]
}

resource "aws_db_subnet_group" "rds-subnet" {
  name       = "rds-subnet"
  subnet_ids = [var.rds_subnet1, var.rds_subnet2]
}