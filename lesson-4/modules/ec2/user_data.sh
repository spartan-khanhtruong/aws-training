#!/bin/bash
sudo yum update -y
sudo dnf update -y
sudo dnf install postgresql15 -y
sudo yum install git -y
sudo git clone https://github.com/spartan-longnguyen/aws-training-rds.git
cd aws-training-rds
export DB_USERNAME=${db_username}
export DB_PASSWORD=${db_password}
export DB_HOST=${db_host}
export DB_PORT=${db_port}
export DB_NAME=${db_name}
sudo dnf install python3-pip -y
pip install Flask Flask-Migrate psycopg2-binary
alembic init migrations
sudo sed -i "s|sqlalchemy.url = .*|sqlalchemy.url = postgresql://${db_username}:${db_password}@${db_host}:${db_port}/${db_name}|" alembic.ini
sudo sed -i '/# add your model.*/a from models import db' migrations/env.py
sudo sed -i 's|target_metadata = None|target_metadata = db.metadata|' migrations/env.py
alembic upgrade head
python3 app.py