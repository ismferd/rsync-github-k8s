# kryncer

This action sync github repository with your pods 

## Inputs

### `cluster`

**Required** The cluster where you are going to operate.

### `namespace`

**Required** The name of the namespaces where reside your app.

### `app`

**Required** The the name of your app  which should map with the app selector in k8s.

### `source_dir`

**Required** The name of your repo source folder.

### `dest_dir`

**Required** The name of your repo dest folder.

## Example usage

```yaml
name: Merge to master CI

on:
  push:
    branches:
      - foo

env:
  CLUSTER: my-cluster
  NAMESPACE: foobar
  APP: app
  ENVIRONMENT: env
  ACCOUNT_ID: 111122223333

jobs:
  transfer_build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2

      - name: Assume DEV Role
        uses: youyo/awscredswrap@master
        with:
          role_arn: arn:aws:iam::${{ env.ACCOUNT_ID}}:role/my_role
          duration_seconds: 1200
          role_session_name: my_role
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: 'eu-central-1'

      - name: Syncing
        uses: ismferd/rsync-github-k8s@main
        with:
          cluster: ${{ env.CLUSTER }}
          namespace: ${{ env.NAMESPACE }}
          app: ${{ env.APP }}
          source_dir: foo
          dest_dir: bar
```
