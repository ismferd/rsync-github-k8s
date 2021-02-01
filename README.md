# kryncer

This action sync github repository with your pods 

## Requirements

- Install `kubectl` in your workflow.
- Update kubeconfig file allowing commands from your workflow.

## Inputs

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
      - name: Syncimg
        uses: ismferd/rsync-github-k8s@master
        env:
          namespace: ${{ secrets.PROJECT }}
          app: ${{ secrets.renderservice }}
          source_dir: .git/*
          dest_dir: /opt/foo/bar
```
