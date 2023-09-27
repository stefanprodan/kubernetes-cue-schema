#!/usr/bin/env bash

# Copyright 2023 Stefan Prodan
# SPDX-License-Identifier: Apache-2.0

set -o errexit

BASEDIR=$(git rev-parse --show-toplevel)

diff_push() {
  artifact_version=$1
  artifact_path=$2
  artifact_repo=$3

  flux diff artifact ${artifact_repo}:${artifact_version} \
    --path="${artifact_path}" &>/dev/null || diff_exit_code=$?

  if [[  ${diff_exit_code} -ne 0 ]]; then
    timoni artifact push ${artifact_repo} \
    		-f ${artifact_path} -t ${artifact_version} -t latest \
    		-a="org.opencontainers.image.source=https://github.com/stefanprodan/kubernetes-cue-schema" \
    		-a="org.opencontainers.image.revision=$(git branch --show-current)@sha1:$(git rev-parse HEAD)" \
    		-a="org.opencontainers.image.licenses=Apache-2.0" \
    		-a="org.opencontainers.image.documentation=https://timoni.sh" \
    		-a="org.opencontainers.image.description=Kubernetes CUE Schemas for timoni.sh" \
    		--content-type="cue.mod/gen"
  else
    echo "✔ no changes detected in ${artifact_path}"
    return
  fi

  echo "✔ pushed to ${artifact_repo}:${artifact_version}"
}

for dir in ${BASEDIR}/schemas/*/
do
    dir=${dir%*/}
    version="${dir##*/}"

    diff_push ${version} ${dir} "oci://ghcr.io/stefanprodan/timoni/kubernetes-schema"
done
