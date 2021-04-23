#!/usr/bin/env bash

cd $HOME/agnosticd/ansible/ && ansible-playbook \
  -i localhost, \
  -c local \
  -e "ansible_python_interpreter=`which python`" \
  -e"ACTION=create-user" \
  -e"ocp_workload=ocp4-workload-mlops" \
  -e"silent=False" \
  -e"user=$user" \
  ./configs/ocp-workloads/ocp-workload.yml