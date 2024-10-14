#!/usr/bin/env bash

# Copyright 2023 Stefan Prodan
# SPDX-License-Identifier: Apache-2.0

set -uo errexit

VERSION="$1"
read MINORVERSION < <(echo ${VERSION} | ( IFS=".$IFS" ; read a b c && echo $b ))

BASEDIR=$(git rev-parse --show-toplevel)
WORKDIR="${BASEDIR}/tmp/k8s-${VERSION}"
DSTDIR="${BASEDIR}/schemas/v1.${MINORVERSION}"

# Create temporary working dir.
rm -rf ${WORKDIR}
mkdir -p ${WORKDIR}
cd ${WORKDIR}

echo "Generating CUE schemas for Kubernetes v1.${MINORVERSION}"

# Create go.mod for the given Kubernetes API version.
tee go.mod >/dev/null <<EOF
module timoni.sh/k8s

go 1.23

require (
	k8s.io/api ${VERSION}
	k8s.io/apiextensions-apiserver ${VERSION}
	k8s.io/apimachinery ${VERSION}
)
EOF

# Create main.go that imports the given Kubernetes API version.
tee main.go >/dev/null <<EOF
package main

import (
	_ "k8s.io/api/core/v1"
	_ "k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1"
	_ "k8s.io/apimachinery/pkg/types"
)
EOF

# Download the Kubernetes packages for the given version.
go mod tidy

# Generate the CUE schemas from the Kubernetes API Go packages.
cue mod init "timoni.sh/k8s"
cue get go k8s.io/api/...
cue get go k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1

# Remove non-GA APIs.
APIDIR="./cue.mod/gen/k8s.io/api"
find ${APIDIR} -name 'v1alpha*' -type d -prune -exec rm -rf {} +
find ${APIDIR} -name 'v2alpha*' -type d -prune -exec rm -rf {} +
find ${APIDIR} -name 'v1beta*' -type d -prune -exec rm -rf {} +
find ${APIDIR} -name 'v2beta*' -type d -prune -exec rm -rf {} +
find ${APIDIR} -empty -type d -delete

# Move generated files to schemas.
rm -rf ${DSTDIR}
mkdir -p ${DSTDIR}
K8SDIR="./cue.mod/gen"
mv ${K8SDIR}/*  ${DSTDIR}/

# Validate schemas.
cd ${DSTDIR}
cue vet ./... --concrete --strict

echo "CUE schemas wrote to 'schemas/v1.${MINORVERSION}' size $(du -sh ${DSTDIR}/ | cut -f1)"
