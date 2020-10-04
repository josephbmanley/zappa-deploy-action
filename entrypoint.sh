#!/bin/sh
set -e

# Move to project directory
cd $GITHUB_WORKSPACE/$1

# Config AWS profile
mkdir -p ~/.aws
echo "[default]" > ~/.aws/config
echo "region=${AWS_DEFAULT_REGION:-'us-east-1'}" >> ~/.aws/config

echo "[default]" > ~/.aws/credentials
echo "aws_access_key_id=${AWS_ACCESS_KEY_ID}" >> ~/.aws/credentials
echo "aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}" >> ~/.aws/credentials

# Install virtual environment
virtualenv .venv
source ./.venv/bin/activate

# Install requirements
pip install zappa
pip install -r requirements.txt

{
    # Check status (whether to update or deploy)
    zappa status $2

    # Update environment
    echo "Starting update..."
    zappa update $2
} || {
    # Deploy environment
    echo "Starting deployment..."
    zappa deploy $2
   
}