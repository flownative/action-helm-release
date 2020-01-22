# Helm Release Action

This Github action allows you to package and push [Helm](https://helm.sh) charts to a repository (for example,
[Chartmuseum](https://chartmuseum.com/)).

Note that this action uses a Helm 3 client.

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
      - uses: actions/checkout@v2

      - name: Build Docker image
        uses: flownative/action-docker-build@v1
        with:
          tag_ref: ${{ github.ref }}
          image_name: flownative/example-app
          registry_password: ${{ secrets.GITHUB_TOKEN }}

  helm-release:
    runs-on: ubuntu-latest
    needs: release
    steps:
      - uses: actions/checkout@v2

      - name: Determine latest released version
        id: latest_version
        uses: flownative/action-git-latest-release@v1


      - name: Release Helm chart
        uses: flownative/action-helm-release@v1
        with:
          charts_folder: 'Helm'
          chart_name: 'example-app'
          chart_version: ${{ steps.latest_version.outputs.tag }}
          app_version: ${{ steps.latest_version.outputs.tag }}
          repository_url: 'https://charts.example.com'
          repository_user: '${{ secrets.CHARTMUSEUM_USER }}'
          repository_password: '${{ secrets.CHARTMUSEUM_PASSWORD }}'
````

## Implementation Note

The repository of this action does not contain the actual implementation code. Instead, it's referring to a pre-build
image in its `Dockerfile` in order to save resources and speed up workflow runs.

The code of this action can be found [here](https://github.com/flownative/docker-action-helm-release).
