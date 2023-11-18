data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")

  vars = {
    db_username = var.db_username
    db_password = var.db_password
    db_host     = var.db_host
    db_port     = var.db_port
    db_name     = var.db_name
  }
}