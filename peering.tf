########################vpc peering #####################################

resource "aws_vpc_peering_connection" "foo" {
  peer_vpc_id   = aws_vpc.vpc_1.id
  vpc_id        = aws_vpc.vpc_2.id
  auto_accept   = true
  tags = {
    Name = "VPC Peering between Public and Private1"
  }
}


resource "aws_vpc_peering_connection" "goo" {
  peer_vpc_id   = aws_vpc.vpc_2.id
  vpc_id        = aws_vpc.vpc_3.id
  auto_accept   = true
  tags = {
    Name = "VPC Peering between private1 and Private2"
  }
}


resource "aws_vpc_peering_connection" "hoo" {
  peer_vpc_id   = aws_vpc.vpc_3.id
  vpc_id        = aws_vpc.vpc_1.id
  auto_accept   = true
  tags = {
    Name = "VPC Peering between private2 and Public"
  }
}
