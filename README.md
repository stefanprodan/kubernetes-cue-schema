# Kubernetes CUE Schemas

[![license](https://img.shields.io/github/license/stefanprodan/kubernetes-cue-schema.svg)](https://github.com/stefanprodan/kubernetes-cue-schema/blob/main/LICENSE)

This repository contains a set of curated CUE schemas for the most recent Kubernetes GA APIs.
These schemas are intended to be used when authoring [Timoni](https://github.com/stefanprodan/timoni) modules.

## Versioned schemas

For each Kubernetes **minor version** there is a dedicated set of CUE schemas stored in this repository
under [/schemas](https://github.com/stefanprodan/kubernetes-cue-schema/tree/main/schemas).

Kubernetes API schemas:

- `k8s.io/api/admission/v1`
- `k8s.io/api/admissionregistration/v1`
- `k8s.io/api/apidiscovery/v2`
- `k8s.io/api/apps/v1`
- `k8s.io/api/authentication/v1`
- `k8s.io/api/authorization/v1`
- `k8s.io/api/autoscaling/v2`
- `k8s.io/api/autoscaling/v1`
- `k8s.io/api/batch/v1`
- `k8s.io/api/certificates/v1`
- `k8s.io/api/coordination/v1`
- `k8s.io/api/core/v1`
- `k8s.io/api/discovery/v1`
- `k8s.io/api/events/v1`
- `k8s.io/api/flowcontrol/v1`
- `k8s.io/api/networking/v1`
- `k8s.io/api/node/v1`
- `k8s.io/api/policy/v1`
- `k8s.io/api/rbac/v1`
- `k8s.io/api/scheduling/v1`
- `k8s.io/api/storage/v1`

The schema of each Kubernetes **minor version** is published to GitHub Container Registry at
[ghcr.io/stefanprodan/timoni/kubernetes-schema](https://github.com/stefanprodan/kubernetes-cue-schema/pkgs/container/timoni%2Fkubernetes-schema).

OCI artifacts:

- `oci://ghcr.io/stefanprodan/timoni/kubernetes-schema:v1.31`
- `oci://ghcr.io/stefanprodan/timoni/kubernetes-schema:v1.30`
- `oci://ghcr.io/stefanprodan/timoni/kubernetes-schema:v1.29`
- `oci://ghcr.io/stefanprodan/timoni/kubernetes-schema:v1.28`
- `oci://ghcr.io/stefanprodan/timoni/kubernetes-schema:v1.27`
- `oci://ghcr.io/stefanprodan/timoni/kubernetes-schema:v1.26`
- `oci://ghcr.io/stefanprodan/timoni/kubernetes-schema:v1.25`
