resource "aws_vpc" "vpc_1" {
  cidr_block = var.vpc1_cidr
  tags = {
    name = "Prod"
}
}

resource "aws_vpc" "vpc_2" {
  cidr_block = var.vpc2_cidr
  tags = {
    name = "Dev"
}
}

resource "aws_vpc" "vpc_3" {
  cidr_block = var.vpc3_cidr
  tags = {
    name = "UAT"
}
}

##########Subnets######################################

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.vpc_1.id
  cidr_block              = var.subnet1_cidr
  availability_zone       = var.zone
  map_public_ip_on_launch = "true"

  tags = {
    Name = "tf-example"
  }
}


resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.vpc_2.id
  cidr_block = var.subnet2_cidr
  availability_zone = var.zone
  map_public_ip_on_launch = "false"

  tags = {
    name = "test"
}
}

resource "aws_subnet" "subnet3" {
  vpc_id = aws_vpc.vpc_3.id
  cidr_block = var.subnet3_cidr
  availability_zone = var.zone1
  map_public_ip_on_launch = "false"

  tags = {
    name = "test"
}
}
#####RT for igw####################################
resource "aws_internet_gateway" "public_igw" {
  vpc_id = aws_vpc.vpc_1.id

  tags = {
    Name = "igw"
  }
}

resource "aws_route_table" "route1" {
  vpc_id = aws_vpc.vpc_1.id
  route {

    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_igw.id
  }

  route {
    cidr_block = var.vpc2_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.foo.id
  }

  route {
    cidr_block = var.vpc3_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.hoo.id
  }

  tags = {
    Name = "public-route"
  }
}

resource "aws_route_table_association" "rta1" {
  route_table_id = aws_route_table.route1.id
  subnet_id = aws_subnet.subnet1.id

}
###################RT for private subnet######################
resource "aws_route_table" "route2" {
  vpc_id = aws_vpc.vpc_2.id
  route {
    cidr_block = var.vpc1_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.foo.id
  }

  route {
    cidr_block = var.vpc3_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.goo.id
  }

  tags = {
    Name = "private-route1"
  }
}

resource "aws_route_table_association" "rta2" {
  route_table_id = aws_route_table.route2.id
  subnet_id = aws_subnet.subnet2.id

}


resource "aws_route_table" "route3" {
  vpc_id = aws_vpc.vpc_3.id
  route {
    cidr_block = var.vpc1_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.hoo.id
  }

  route {
    cidr_block = var.vpc2_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.goo.id
  }

  tags = {
    Name = "private-route2"
  }
}

resource "aws_route_table_association" "rta3" {
  route_table_id = aws_route_table.route3.id
  subnet_id = aws_subnet.subnet3.id

}
########SG for Both#############################################

resource "aws_security_group" "sg1" {
  name = "Prod"
  vpc_id = aws_vpc.vpc_1.id
  ingress {
  from_port = "22"
  to_port = "22"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }


}


resource "aws_security_group" "sg2" {
  name = "dev"
  vpc_id = aws_vpc.vpc_2.id
  ingress {
  from_port = "22"
  to_port = "22"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }


}

resource "aws_security_group" "sg3" {
  name = "UAT"
  vpc_id = aws_vpc.vpc_3.id
  ingress {
  from_port = "22"
  to_port = "22"
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }


}
