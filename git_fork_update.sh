#!/bin/bash

# Update fork from master project
# doc: https://gist.github.com/CristinaSolana/1885435

# Clone your fork:
#git clone https://github.com/$my_username/$repo_name
#git pull https://github.com/mkieboom/mapr-ansible

# Update local project
cd ~/DScloud/MapR/Development/github/mapr-ansible/
git pull

# Add remote from original repository in your forked repository:
git remote add upstream https://github.com/mapr-emea/mapr-ansible.git
git fetch upstream

# Updating your fork from original repo to keep up with their changes:
git pull upstream master

# Remove the remote upstream
git remote remove upstream