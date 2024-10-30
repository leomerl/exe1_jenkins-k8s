#!/bin/bash

function main()
{
  set -e

  pushd $(dirname $0)
  
  cd terraform/
  local aws_region=$(terraform output -raw aws_region)
  local eks_cluster_name=$(terraform output -raw eks_cluster_name)
  cd ../

  aws eks --region "${aws_region}" update-kubeconfig --name "${eks_cluster_name}"
  
  deploy_app jenkins jenkins
  deploy_app nexus nexus

  popd
  echo "Deployment of Jenkins and Nexus completed."
}

create_namespace() {
  kubectl create namespace $1 || true
}

deploy_app() {
  local app=$1
  local namespace=$2
  create_namespace "${namespace}"
  kubectl apply -f k8s-manifests/"${app}" -n "${namespace}"
}

main