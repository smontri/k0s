resource "aws_instance" "worker" {
  count         = var.worker_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.cluster_flavor

    tags = tomap({
    "Name" = "${var.cluster_name}-worker-${count.index + 1}",
    "Role" = "worker"
  }
  )

  key_name                    = aws_key_pair.cluster-key.key_name
  vpc_security_group_ids      = [aws_security_group.cluster_allow_ssh.id]
  associate_public_ip_address = true
  source_dest_check = false

  root_block_device {
    volume_type = "gp2"
    volume_size = 20
  }
}