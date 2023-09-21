# Kubernetes CUE Schemas

[![license](https://img.shields.io/github/license/stefanprodan/kubernetes-cue-schema.svg)](https://github.com/stefanprodan/kubernetes-cue-schema/blob/main/LICENSE)

This repository contains a set of curated CUE schemas for the most recent Kubernetes GA APIs.
These schemas are intended to be used when authoring [Timoni](https://github.com/stefanprodan/timoni) modules.

## Versioned schemas

For each Kubernetes **minor version** there is a dedicated set of CUE schemas stored in this repository
under [/schemas](https://github.com/stefanprodan/kubernetes-cue-schema/tree/main/schemas).

The schemas are published to GitHub Container Registry at
[ghcr.io/stefanprodan/timoni/kubernetes-schema](https://github.com/stefanprodan/kubernetes-cue-schema/pkgs/container/timoni%2Fkubernetes-schema).

Available versions:

- `oci://ghcr.io/stefanprodan/timoni/kubernetes-schema:v1.28`
- `oci://ghcr.io/stefanprodan/timoni/kubernetes-schema:v1.27`
- `oci://ghcr.io/stefanprodan/timoni/kubernetes-schema:v1.26`
- `oci://ghcr.io/stefanprodan/timoni/kubernetes-schema:v1.25`
