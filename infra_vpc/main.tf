resource "aws_vpc" "tech-challenge-vpc" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.common_tags, {
    Name = "tech-challenge-vpc"
  })
}

resource "aws_internet_gateway" "tech-challenge-igw" {
  vpc_id = aws_vpc.tech-challenge-vpc.id

  tags = merge(local.common_tags, {
    Name = "tech-challenge-igw"
  })
}

resource "aws_subnet" "tech-challenge-subnet" {
  for_each = {
    "pub_a" : ["192.168.1.0/24", "${var.aws_region}a", "Public A"],
    "pub_b" : ["192.168.2.0/24", "${var.aws_region}b", "Public B"],
  }

  vpc_id            = aws_vpc.tech-challenge-vpc.id
  cidr_block        = each.value[0]
  availability_zone = each.value[1]

  tags = merge(local.common_tags, {
    Name = each.value[2]
  })

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.tech-challenge-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tech-challenge-igw.id
  }

  tags = merge(local.common_tags, {
    Name = "tech-challenge-public"
  })
}

resource "aws_route_table_association" "tech-challenge-route-table" {
  for_each = {
    "pub_a" : aws_subnet.tech-challenge-subnet["pub_a"].id,
    "pub_b" : aws_subnet.tech-challenge-subnet["pub_b"].id,
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.public.id

}

resource "aws_route" "tech-challenge-route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.tech-challenge-igw.id

}
