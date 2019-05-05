#!/bin/bash

GITHUB_REPO=mapr-ansible

# Clone or pull the github repository
cd ~/
if [ -d "$GITHUB_REPO" ]; then
  # Git project already exists, pulling updates
  cd $GITHUB_REPO
  git pull
else
  # Git project does not exists yet, cloning now
  git clone https://github.com/mkieboom/$GITHUB_REPO
  cd $GITHUB_REPO
fi	

# Disable ssh host key checking
export ANSIBLE_HOST_KEY_CHECKING=False

# Install MapR minimum
time ansible-playbook \
  -i myhosts/1node_minimum \
  cluster-minimum.yaml \
  -e force_zookeeper_restart=False \
  -e force_warden_restart=False \
  -e warden_restart_wait_time=0 \
  -e security_encryption_rest=True \
  -e security_all=maprsasl \
  -e disks=/dev/sdb \
  -e memory=low \
  --connection=local
