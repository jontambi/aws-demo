# Create AWS Key Pair
resource "aws_key_pair" "ssh_default" {
    key_name = "ssh_webserver"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCmwPogVFBOpmNhVpBOD+IKzKNd2MGe6fWrN/F+IcecKd3aHgb6A+lgb03OUuK8BkBz7eg5ARhZliYrD/Id/rvX0HOLvDCuo/UVeQd6OuOZlX+pcsTZgUTY1bZzHhxzmwTMQ0mU1tnEpKRMLH8uwVOusaJiAAf4jjVPa3COi/QLcMzraiLaJnvMjYolyFqVcZbQri+ydvYzkHQYlX+nkoLtbfNLWC9NjlvOYCMDpxhDjtFW8sLiuwUZ6XSFyGxgvfdCJzL7VSiQADHK7n0cO4BpN2PyyAZCCEY2hYFd9asVRcY/gfEc7C6xId3SuMuACJqA5x2tY3FY3xbL6Iswa5SD john@geminis"
}

# Create AWS Instance
resource "aws_instance" "wordpress_server" {
    count                  = length(var.private_subnets_cidr)

    ami                    = data.aws_ami.latest_wordpress.id
    availability_zone      = element(var.azs, count.index)
#   availability_zone = "us-east-1b"
    instance_type          = "t2.micro"
    key_name               = aws_key_pair.ssh_default.key_name
#    vpc_security_group_ids = [aws_security_group.connection_allow.id]
    subnet_id              = aws_subnet.main_subnet.id

    tags = {
        Name = "${var.environment}-${var.vpc_name}-wordpress-demo"
    }
}


# AWS Select latest AMI
data "aws_ami" "latest_wordpress" {
    owners = ["179966"]
    most_recent = true

    filter {
        name = "state"
        values = ["available"]
    }

    filter {
        name = "tag:Name"
        values = ["wordpress_img"]
    }
}