#!/usr/bin/env bash
# Helper script for building, tagging and pushing images

# Exit when any command fails
set -e

function INFRA() {
  echo "Calling $PROJECT_ARG"

  echo "$BUILD_CMD build -t $tag $REPO_PATH$image-$version"
  $BUILD_CMD build -t "$tag" "$REPO_PATH$image-$version"

  echo "$BUILD_CMD $tag $ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$tag"
  $BUILD_CMD tag "$tag" "$ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$tag"
  $BUILD_CMD tag "$tag" "$ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$API_NAME:latest"

  aws ecr get-login-password --region "$REGION" | $BUILD_CMD login --username AWS --password-stdin "$ACCOUNT.dkr.ecr.$REGION.amazonaws.com"
  $BUILD_CMD push "$ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$tag"
  $BUILD_CMD push "$ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$API_NAME:latest"
}

function RANGE() {
  echo "Calling $PROJECT_ARG"

  if [[ "$image" == "nginx-lab" ]]; then
    # NOTE: default is ssl
    NGINX_FILE="${ngx["https"]}"
    # Check for nginx file
    if [ -f "./${RNG}_${ENV}-$NGINX_FILE" ]; then
      NGINX_FILE="${RNG}_${ENV}-$NGINX_FILE"
    else
      NGINX_FILE="$NGINX_FILE"
    fi

    cp "./$NGINX_FILE" "$REPO_PATH$image-$version/docker/nginx/conf.d/default.conf"
    echo "$BUILD_CMD build -t $tag $REPO_PATH$image-$version/docker/nginx"
    $BUILD_CMD build -t "$tag" "$REPO_PATH$image-$version/docker/nginx"
  else
    echo "$BUILD_CMD build -t $tag $REPO_PATH$image-$version"
    $BUILD_CMD build -t "$tag" "$REPO_PATH$image-$version"
  fi
  $BUILD_CMD tag "$tag" "$ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$tag"
  $BUILD_CMD tag "$tag" "$ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$API_NAME:latest"

  aws ecr get-login-password --region "$REGION" | $BUILD_CMD login --username AWS --password-stdin "$ACCOUNT.dkr.ecr.$REGION.amazonaws.com"
  $BUILD_CMD push "$ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$tag"
  $BUILD_CMD push "$ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$API_NAME:latest"
}

function GUAC() {
  echo "Calling $PROJECT_ARG"

  if [[ "$image" == "guacamole-client" ]]; then
    if [ -f "./${RNG}_${ENV}-guacamole.properties" ]; then
      GUAC_PROPS="${RNG}_${ENV}-guacamole.properties"
      cp "./$GUAC_PROPS" "$REPO_PATH$image-$version/assets/guacamole.properties"
    fi
  fi

  echo "$BUILD_CMD build -t $tag $REPO_PATH$image-$version"
  $BUILD_CMD build -t "$tag" "$REPO_PATH$image-$version"
  echo "$BUILD_CMD $tag $ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$tag"
  $BUILD_CMD tag "$tag" "$ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$tag"
  $BUILD_CMD tag "$tag" "$ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$API_NAME:latest"

  aws ecr get-login-password --region "$REGION" | $BUILD_CMD login --username AWS --password-stdin "$ACCOUNT.dkr.ecr.$REGION.amazonaws.com"
  $BUILD_CMD push "$ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$tag"
  $BUILD_CMD push "$ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$API_NAME:latest"
}

function cloneProject() {
  #if [[ "$image" != @(memcached) ]]; then
  echo "REPO: $REPO_PATH$image-$version"
  if [ -d "$REPO_PATH$image-$version" ]; then
    rm -rf "$REPO_PATH$image-$version"
  fi
  echo "$version"
  echo "$image"
  current_dir=$(pwd)
  git clone "git@github.com:franknaw/$image.git" "$REPO_PATH$image-$version"
  cd "$REPO_PATH$image-$version"
  git checkout "$version"
  cd "$current_dir"
  # This command errors with repo not found.
  #git clone --depth 1 --branch "$version git@bitbucket.org:cvle-public/$image.git" "$REPO_PATH$image-$version"
  #fi
}

function build_image() {
  for COMPVER in "${images[@]}"; do
    read -ra PARTS <<<"$COMPVER"
    CVLE_VERSION="${PARTS[0]}"
    API_NAME="${PARTS[1]}"
    API_VERSION="${PARTS[2]}"
    PROJECT="${PARTS[3]}"
    if [[ "$CVLE_VERSION" == "$CVLE_VERSION_ARG" && "$PROJECT" == "$PROJECT_ARG" ]]; then
      version="v$API_VERSION"
      tag="$API_NAME:$API_VERSION"
      tag_version=$API_VERSION
      image=$API_NAME
      if [[ ! -z "$1" ]]; then
        if [[ "$1" == "$image" ]]; then
          echo "FOO Build $1 $image"
          # Call clone project
          cloneProject
          # Call project build, tag and push function
          $PROJECT_ARG
          exit 0
        fi
      else
        # Call clone project
        cloneProject
        # Call project build, tag and push function
        $PROJECT_ARG
      fi
    fi
  done
}

function build_image_nginx() {
  for COMPVER in "${images[@]}"; do
    read -ra PARTS <<<"$COMPVER"
    CVLE_VERSION="${PARTS[0]}"
    API_NAME="${PARTS[1]}"
    API_VERSION="${PARTS[2]}"
    PROJECT="${PARTS[3]}"
    if [[ "$CVLE_VERSION" == "$CVLE_VERSION_ARG" && "$PROJECT" == "$PROJECT_ARG" ]]; then
      version="v$API_VERSION"
      tag="$API_NAME:$API_VERSION"
      image=$API_NAME
      if [[ "$image" == "nginx-lab" ]]; then
        # Call clone project
        cloneProject
        # Call project build, tag and push function
        $PROJECT_ARG
        exit 0
      fi
    fi
  done
}

function arg_exception() {
  echo "4 args are required, one is optional"
  echo "arg 1: provision environment (dev)"
  echo "arg 2: region to provision (com-east|com-west)"
  echo "arg 3: Project (INFRA|RANGE|GUAC)"
  echo "arg 4: Version"
  echo "arg 5: \"nginx\" (optional), specific to build Nginx"
  exit 0
}

if [[ "$0" != ../*/*.sh ]]; then
  echo "This is script can only be executed from an API project"
  exit 0
fi

if [[ "$1" == "eval_cvle" ]]; then
  CVLE_VERSION_ARG="$2"
  eval_cvle_version
  exit 0
fi

if [[ "$1" != @(dev) || "$2" != @(com-west|com-east) || "$3" != @(INFRA|RANGE|GUAC) || -z "$4" ]]; then
  arg_exception
fi

. ../../infra-aws-module-tf/acct.sh
echo "$acct"

declare -A env=(["dev"]="$acct")
declare -A reg=(["com-west"]="us-west-1" ["com-east"]="us-east-1")
declare -A ngx=(["http"]="nginx-default.conf" ["https"]="nginx-ssl-default.conf")

BUILD_CMD="podman"
REPO_PATH="../../apis/"

ENV="$1"
RNG="$2"
ACCOUNT="${env[$ENV]}"
PROJECT_ARG="$3"
CVLE_VERSION_ARG="$4"
REGION="${reg[$RNG]}"
SPECIFIC_BUILD="$5"

# Check if API directory exists
if [ ! -d "$REPO_PATH" ]; then
  mkdir "$REPO_PATH"
fi

# Source for API version file
if [ -f "../../infra-aws-module-tf/infra_version.sh" ]; then
  source "../../infra-aws-module-tf/infra_version.sh"
else
  echo "Version file not found"
  exit 1
fi

function eval_cvle_version() {
  for COMPVER in "${images[@]}"; do
    read -ra PARTS <<<"$COMPVER"
    if [[ "$CVLE_VERSION_ARG" == "${PARTS[0]}" ]]; then
      isFound=1
    fi
  done
  if [[ $isFound != 1 ]]; then
    echo "Version \"$CVLE_VERSION_ARG\" not found"
    exit 1
  fi
}

# Start clone, build, tag and push
if [[ "$SPECIFIC_BUILD" == @(nginx|nginx-lab) ]]; then
  build_image_nginx
else

  build_image "$SPECIFIC_BUILD"
fi

###############################################################
# git tag -a v0.0.0 -m "Production 0.0.0"
# git tag -n
# git push --tags
# git clone --depth 1 --branch v0.0.0 git@bitbucket.org:cvle-public/crms-resource-api.git ../../crms-resource-api-v0.0.0
# cd repo
# git checkout tag_name
# git clone git@bitbucket.org:cvle-public/crms-resources-api.git
# podman images | grep "v0.0.0" | awk '{print $3}' | xargs podman rmi
# git branch
# git describe --all
