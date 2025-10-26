resource "aws_vpc" "example" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_subnet" "example" {
  vpc_id            = aws_vpc.example.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "tf-example"
  }
}

data "aws_ami" "amzn-linux-2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "c6a.2xlarge"
  subnet_id     = aws_subnet.example.id
  metadata_options {
    http_tokens = "required"
  }
  
  cpu_options {
    core_count       = 2
    threads_per_core = 2
  }
 root_block_device {
    encrypted = true
  }

  ebs_block_device {
    device_name = "/dev/sdg"
    encrypted   = true
    }
  tags = {
    Name = "tf-example"
  }
}