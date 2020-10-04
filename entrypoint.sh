#!/bin/sh
set -e

# Move to project directory
cd $1

# Install virtual environment
pip install virtualenv
virtualenv .venv
source ./.venv/bin/activate

# Install requirements
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