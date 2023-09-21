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
    flux_output=$(flux push artifact ${artifact_repo}:${artifact_version} \
      --path="${artifact_path}" \
      --source="https://github.com/stefanprodan/kubernetes-cue-schema" \
      --annotations='org.opencontainers.image.licenses=Apache-2.0' \
      --annotations='org.opencontainers.image.documentation=https://timoni.sh' \
      --annotations='org.opencontainers.image.description=Kubernetes CUE Schemas for timoni.sh' \
      --revision="$(git branch --show-current)@sha1:$(git rev-parse HEAD)" 2>&1) || exit_code=$?

     oci_url=$(echo ${flux_output} | tail -n1 | awk '/to/{print $NF}')

     flux tag artifact ${artifact_repo}:${artifact_version} --tag=latest
  else
    echo "✔ no changes detected in ${artifact_path}"
    return
  fi

  if [[  ${exit_code} -ne 0 ]]; then
    echo ${flux_output}
    exit 1
  fi

  echo "✔ pushed to ${oci_url}"
}

for dir in ${BASEDIR}/schemas/*/
do
    dir=${dir%*/}
    version="${dir##*/}"

    diff_push ${version} ${dir} "oci://ghcr.io/stefanprodan/timoni/kubernetes-schema"
done
