#!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd.x86_64
              sudo systemctl start httpd.service
              sudo systemctl enable httpd.service
              echo "Hello World from $(hostname -f)" | sudo tee /var/www/html/index.html