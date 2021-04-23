#!/usr/bin/env bash

mkdir -p /tmp/src
export PATH=$PATH:/tmp/src/bin

mkdir -p /tmp/src/bin
export HELM_INSTALL_DIR=/tmp/src/bin
export USE_SUDO=false
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

curl -o /tmp/openshift-client-linux.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp/stable/openshift-client-linux.tar.gz 
tar xzf /tmp/openshift-client-linux.tar.gz -C /tmp/src/bin
rm /tmp/src/bin/README.md

echo "------"
echo "GIT_URL: $GIT_URL"
echo "GIT_REFSPEC: $GIT_REFSPEC"
echo "------"

mkdir -p /tmp/src/agnosticd
git clone $GIT_URL /tmp/src/agnosticd
(cd /tmp/src/agnosticd && git checkout $GIT_REFSPEC)

cat << EOF > /tmp/src/.ansible.cfg 
[defaults]
  callback_whitelist = profile_tasks
EOF