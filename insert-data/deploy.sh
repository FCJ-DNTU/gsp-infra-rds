#!/bin/bash

# Use in Ubuntu Server

# Set up ENV
DB_HOST="your-rds-endpoint"
DB_NAME="awsfcjuser"
DB_USER="admin"

# Update packages
sudo yum update -y

function checkCommand() {
  if command -v $1 &> /dev/null; then
    echo "$1 installation found"
  else
    echo "$1 installation not found. Please install $1."
    exit 1
  fi
}

# Install MySQL Client
sudo apt install mysql -y

## Check mysql
checkCommand mysql

## Run sql script and insert data
mysql -h $DB_HOST -u $DB_USER $DB_NAME -p < init.sql

echo "Insert data done"