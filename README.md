# Helm Push Action

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

      - name: Release Helm chart
        uses: flownative/action-helm-push@v1
        with:
          charts_folder: 'Helm'
          chart_name: 'example-app'
          repository_url: 'https://charts.example.com'
          repository_user: '${{ secrets.CHARTMUSEUM_USER }}'
          repository_password: '${{ secrets.CHARTMUSEUM_PASSWORD }}'
````
