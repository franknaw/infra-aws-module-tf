#!/usr/bin/env bash

function set_exit_on_error() {
  # Exit when any command fails
  set -e
}

function run_init() {
  terraform init
}

function run_show() {
  if [[ "$project" != @(rds) ]]; then
    terraform show -json "$REGION-$ENV-$CVLE_VERSION_ARG-state.tfstate" | python3 -m json.tool >../outputs/"$REGION-$ENV-$CVLE_VERSION_ARG-$DATE-$REPO-$1".json
  else
    terraform show -json "$REGION-$ENV-state.tfstate" | python3 -m json.tool >../outputs/"$REGION-$ENV-$CVLE_VERSION_ARG-$DATE-$REPO-$1".json
  fi
}

function run_apply() {
  if [[ "$project" != @(rds) ]]; then
    terraform apply -state="$REGION-$ENV-$CVLE_VERSION_ARG-state.tfstate" -var="env=$ENV" -var="region=$REGION" -var="cvle_version=$CVLE_VERSION_ARG" -auto-approve
  else
    terraform apply -state="$REGION-$ENV-state.tfstate" -var="env=$ENV" -var="region=$REGION" -var="cvle_version=$CVLE_VERSION_ARG" -auto-approve
  fi
}

function run_plan() {
  if [[ "$project" != @(rds) ]]; then
    terraform plan -state="$REGION-$ENV-$CVLE_VERSION_ARG-state.tfstate" -var="env=$ENV" -var="region=$REGION" -var="cvle_version=$CVLE_VERSION_ARG"
  else
    terraform plan -state="$REGION-$ENV-state.tfstate" -var="env=$ENV" -var="region=$REGION" -var="cvle_version=$CVLE_VERSION_ARG"
  fi
}

function run_destroy() {
  if [[ "$project" != @(rds) ]]; then
    terraform destroy -state="$REGION-$ENV-$DESTROY_CVLE_VERSION_ARG-state.tfstate" -var="env=$ENV" -var="region=$REGION" -var="cvle_version=$DESTROY_CVLE_VERSION_ARG" -auto-approve
  else
    terraform destroy -state="$REGION-$ENV-state.tfstate" -var="env=$ENV" -var="region=$REGION" -var="cvle_version=$CVLE_VERSION_ARG" -auto-approve
  fi
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
    run_init
    run_apply
    if [[ "$project" == "ecr" ]]; then
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
  echo "arg 3: component sequence (ecr|rds|ecs|route53|all)"
  echo "arg 4: project (RANGE|GUAC)"
  echo "arg 5: region (com-west|com-east)"
  echo "arg 6: Version"
  exit 0
}

#############################################################################

if [[ "$0" != ../*/*.sh ]]; then
  echo "This is script can only be executed from an API project"
  exit 0
fi

if [[ $# -ne 6 || "$1" != @(dev) || "$2" != @(plan|apply|show|destroy) || "$3" != @(ecr|rds|ecs|route53|all) || "$4" != @(RANGE|GUAC) || "$5" != @(com-west|com-east) || -z "$6" ]]; then
  arg_exception
fi

DATE=$(date '+%Y%m%d%H%M%S')
ENV=$1
FUNC=$2
PROJECT_ARG=$3
REPO="$4"
REGION="$5"
CVLE_VERSION_ARG="$6"
DESTROY_CVLE_VERSION_ARG="$CVLE_VERSION_ARG"

# Source for API version file
if [ -f "../infra-aws-module-tf/infra_version.sh" ]; then
  source "../infra-aws-module-tf/infra_version.sh"
fi

function proceedWithChangingCvleVersion() {
  DESTROY_CVLE_VERSION_ARG="$last_cvle_version"
  projects_destroy
}

# Test valid CVLE Version
function eval_cvle() {
  for COMPVER in "${images[@]}"; do
    read -ra PARTS <<<"$COMPVER"
    if [[ "$CVLE_VERSION_ARG" == "${PARTS[0]}" ]]; then
      isFound=1
    fi
  done
  if [[ $isFound != 1 ]]; then
    echo "CVLE Version \"$CVLE_VERSION_ARG\" not found"
    exit 1
  fi
}
eval_cvle

if [[ "$ENV" == "prod" && "$FUNC" == @(apply|destroy) ]]; then
  echo "Currently NA"
  echo "Disable this block to enable"
  exit 0
fi

if [[ "$PROJECT_ARG" == "all" ]]; then
  declare -a projects=("ecr" "rds" "ecs" "route53")
  declare -a projects_destroy=("ecs" "ecr" "rds" "route53")
else
  declare -a projects=("$PROJECT_ARG")
  declare -a projects_destroy=("$PROJECT_ARG")
fi

if [[ "$FUNC" == "apply" ]]; then
  if [[ "$PROJECT_ARG" != @(rds) ]]; then
    if [ ! -f "../infra-aws-module-tf/last_cvle_version-${ENV}-${REGION}-${REPO}.sh" ]; then
      echo "last_cvle_version=$CVLE_VERSION_ARG" > "../infra-aws-module-tf/last_cvle_version-${ENV}-${REGION}-${REPO}.sh"
      chmod 755 "../infra-aws-module-tf/last_cvle_version-${ENV}-${REGION}-${REPO}.sh"
      source "../infra-aws-module-tf/last_cvle_version-${ENV}-${REGION}-${REPO}.sh"
    else
      source "../infra-aws-module-tf/last_cvle_version-${ENV}-${REGION}-${REPO}.sh"
    fi
    if [[ "$last_cvle_version" != "$CVLE_VERSION_ARG" ]]; then
      echo "Do you wish to destroy the prior CVLE version?, Yes or No"
      select yn in "Yes" "No"; do
        case $yn in
          Yes ) proceedWithChangingCvleVersion;;
          No ) exit;;
        esac
      done
    fi
    projects_apply
  else
    projects_apply
  fi
elif [[ "$FUNC" == "plan" ]]; then
  projects_plan
elif [[ "$FUNC" == "show" ]]; then
  projects_show
elif [[ "$FUNC" == "destroy" ]]; then
  projects_destroy
  if [[ "$PROJECT_ARG" == @(all) ]]; then
    rm "../infra-aws-module-tf/last_cvle_version-${ENV}-${REGION}-${REPO}.sh"
  fi
fi

if [[ "$FUNC" == "apply" ]]; then
  if [[ "$PROJECT_ARG" != @(rds) ]]; then
    source "../infra-aws-module-tf/last_cvle_version-${ENV}-${REGION}-${REPO}.sh"
    if [[ "$last_cvle_version" != "$CVLE_VERSION_ARG" ]]; then
      echo "last_cvle_version=$CVLE_VERSION_ARG" > "../infra-aws-module-tf/last_cvle_version-${ENV}-${REGION}-${REPO}.sh"
    fi
  fi
fi

# find . -name .terraform* -exec rm -rf {} \;
# find . -name terraform* -exec rm -rf {} \;
# find . -name *tfstate* -exec rm -rf {} \;



