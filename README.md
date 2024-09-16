# Helm Release Action

This GitHub action allows you to package and push [Helm](https://helm.sh) 
charts to a OCI compatible repository (for example,
[Harbor](https://www.harbor.io)).

Note that this action uses a Helm 3 client and Chart Museum is not supported 
anymore.

## Example workflow

````yaml
name: Build and release Docker image
on:
  push:
    branches-ignore:
      - '**'
    tags:
      - 'v*.*.*'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      # Build container image ...
  helm-release:
    runs-on: ubuntu-latest
    needs: release
    steps:
      - uses: actions/checkout@v4

      - name: Determine latest released version
        id: latest_version
        uses: flownative/action-git-latest-release@v1

      - name: Release Helm chart
        uses: flownative/action-helm-release@v2
        with:
          charts_folder: 'Helm'
          chart_name: 'example-app'
          chart_version: ${{ steps.latest_version.outputs.tag }}
          app_version: ${{ steps.latest_version.outputs.tag }}
          registry_host: 'harbor.example.com'
          repository_path: 'my-charts'
          repository_user: '${{ secrets.HARBOR_ROBOT_USER }}'
          repository_password: '${{ secrets.HARBOR_ROBOT_PASSWORD }}'
````

## Implementation Note

The repository of this action does not contain the actual implementation code. Instead, it's referring to a pre-build
image in its `Dockerfile` in order to save resources and speed up workflow runs.

The code of this action can be found [here](https://github.com/flownative/docker-action-helm-release).
