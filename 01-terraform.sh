#!/bin/bash


function main()
{
  pushd $(dirname $0)/terraform/
  deploy
  create_keys
  popd
}

function deploy()
{
  set -e

  terraform init
  terraform validate
  terraform plan -out=tfplan
  terraform apply -auto-approve tfplan
  terraform output > output
}

function create_keys()
{
mkdir -p keys
chmod 700 keys
terraform output -raw ec2_private_key_pem > keys/ec2_private_key.pem
chmod 600 keys/ec2_private_key.pem
}

main
