#!/bin/bash

function main()
{
  pushd $(dirname $0)/terraform/
  cleanup
  popd
}

function cleanup()
{
  set -e

  echo "Destroying Terraform-managed infrastructure..."
  terraform destroy -auto-approve
  rm -rf keys
}

main
