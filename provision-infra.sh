#!/usr/bin/env bash

function set_exit_on_error() {
  # Exit when any command fails
  set -e
}

function run_init() {
  terraform init
}

function run_apply() {
  terraform apply -state="$REGION-$ENV-state.tfstate" -var="env=$ENV" -var="region=$REGION" -auto-approve
}

function run_show() {
  terraform show -json "$REGION-$ENV-state.tfstate" | python3 -m json.tool >../outputs/"$REGION-$ENV-$DATE-$REPO-$1".json
}

function run_plan() {
  terraform plan -var="env=$ENV" -var="region=$REGION"
}

function run_destroy() {
  terraform destroy -state="$REGION-$ENV-state.tfstate" -var="env=$ENV" -var="region=$REGION" -auto-approve
}

function terraform_show() {
  for project in "$@"; do
    echo "################################### SHOW $project ###################################"
    cd "$project"
    run_show "$project"
    cd ..
  done
}

function terraform_apply() {
  set_exit_on_error
  for project in "$@"; do
    echo "################################### APPLY $project ###################################"
    cd "$project"
    if [[ "$project" == "alb" ]]; then
      ./genCert.sh "$ENV" "$REGION"
    fi
    run_init
    run_apply
    if [[ "$project" == "ecr" ]]; then
      echo "Build Image"
      ../../infra-aws-module-tf/image-provision.sh "$ENV" "$REGION" "$REPO" "$CVLE_VERSION_ARG"
    fi
    cd ..
  done
}

function terraform_plan() {
  for project in "$@"; do
    echo "################################### PLAN $project ###################################"
    cd "$project"
    run_init
    run_plan
    cd ..
  done
}

function terraform_destroy() {
  for project in "$@"; do
    echo "################################### DESTROY $project ###################################"
    cd "$project"
    run_destroy
    cd ..
  done
}

function projects_apply() {
  terraform_apply "${projects[@]}"
}

function projects_plan() {
  terraform_plan "${projects[@]}"
}

function projects_show() {
  terraform_show "${projects[@]}"
}

function projects_destroy() {
  terraform_destroy "${projects_destroy[@]}"
}

function arg_exception() {
  echo "6 args are required"
  echo "arg 1: provision environment (dev)"
  echo "arg 2: terraform function (apply|plan|show|destroy)"
  echo "arg 3: component sequence (vpc|vpc_peerings|gateways|security_groups|route_tables|vpc_endpoints|route53|alb|ecr|ecs|all)"
  echo "arg 4: project (INFRA)"
  echo "arg 5: region (com-west|com-east)"
  echo "arg 6: API Version"
  exit 0
}

#############################################################################
# Helper bash script for running terraform commands.  Please see README file.
# To execute: "./provision argument arg1 arg2 arg3" from the command line
# To Note: ALl other subsequent projects depends on VPC
# To Note: route_tables depends on vpc_peerings
# To Note: vpc_endpoints depends on security_groups

if [[ "$0" != ../*/*.sh ]]; then
  echo "This is script can only be executed from the INFRA-AWS-TF project"
  exit 0
fi

if [[ $# -ne 6
      || "$1" != @(dev)
      || "$2" != @(plan|apply|show|destroy)
      || "$3" != @(vpc|vpc_peerings|gateways|security_groups|route_tables|vpc_endpoints|route53|alb|ecr|ecs|all)
      || "$4" != @(INFRA)
      || "$5" != @(com-west|com-east)
      || -z "$6" ]]; then
  arg_exception
fi

ENV=$1
REGION="$5"
DATE=$(date '+%Y%m%d%H%M%S')
REPO="$4"
CVLE_VERSION_ARG="$6"
# Set AWS creds.
#./tf-creds.sh

# Source for API version file
if [ -f "../infra-aws-module-tf/infra_version.sh" ]; then
  source "../infra-aws-module-tf/infra_version.sh"
fi

# Test valid INFRA Version
function eval_cvle() {
  for COMPVER in "${images[@]}"; do
    read -ra PARTS <<<"$COMPVER"
    if [[ "$CVLE_VERSION_ARG" == "${PARTS[0]}" ]]; then
      isFound=1
    fi
  done
  if [[ $isFound != 1 ]]; then
    echo "INFRA Version \"$CVLE_VERSION_ARG\" not found"
    exit 1
  fi
}
eval_cvle

if [[ "$1" == "prod" && "$2" == @(images|apply|destroy) ]]; then
  echo "Currently NA"
  echo "Disable this block to enable"
  exit 0
fi

if [[ "$3" == "all" ]]; then
  declare -a projects=("vpc" "vpc_peerings" "gateways" "security_groups" "route_tables" "vpc_endpoints" "route53" "alb" "ecr" "ecs")
  declare -a projects_destroy=("ecs" "ecr" "alb" "route53" "vpc_endpoints" "route_tables" "security_groups" "gateways" "vpc_peerings" "vpc")
else
  declare -a projects=("$3")
  declare -a projects_destroy=("$3")
fi

if [[ "$2" == "apply" ]]; then
  projects_apply
elif [[ "$2" == "plan" ]]; then
  projects_plan
elif [[ "$2" == "show" ]]; then
  projects_show
elif [[ "$2" == "destroy" ]]; then
  projects_destroy
fi

# find . -name .terraform* -exec rm -rf {} \;
# find . -name terraform* -exec rm -rf {} \;
# find . -name *tfstate* -exec rm -rf {} \;
