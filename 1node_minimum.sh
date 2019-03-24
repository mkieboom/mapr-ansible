#!/bin/bash

# Disable ssh host key checking
export ANSIBLE_HOST_KEY_CHECKING=False

time ansible-playbook \
  -i myhosts/1node_minimum \
  cluster-minimum.yaml \
  -e warden_restart_wait_time=0 \
  -e security_encryption_rest=True \
  -e security_all=maprsasl \
  -e disks=/dev/sdb \
  --connection=local
