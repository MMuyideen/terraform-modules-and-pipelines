vpc_cidr_block = "10.0.0.0/16"
project_name   = "deen-test"

availability_zones = ["us-east-1a", "us-east-1b"]

public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]

enable_nat_gateway = false
single_nat_gateway = false

instance_type     = "t3.micro"
ssh_allowed_cidrs = ["0.0.0.0/0"]

ingress_rules = [
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access"
  },
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }
]

egress_rules = [
  {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound HTTPS"
  },
  {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow outbound DNS"
  }
]

tags = {
  Environment = "test"
  ManagedBy   = "terraform"
}
