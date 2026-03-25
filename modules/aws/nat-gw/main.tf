resource "aws_eip" "nat" {
  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-eip"
    }
  )

  depends_on = []
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = var.subnet_id

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-nat"
    }
  )

  depends_on = [aws_eip.nat]
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-private-rt"
    }
  )
}

resource "aws_route_table_association" "private" {
  for_each = toset(var.private_subnet_ids)

  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}
