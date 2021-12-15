# mirror-sync

Synchronizing mirrored repositories bidirectionally

## Setup

This action assume that you have a repository on a remote location and that you want to synchronize it with mirror on GitHub.

### Step 1

Create a repository on GitHub

### Step 2

Mirror the repository following [these steps](https://docs.github.com/en/repositories/creating-and-managing-repositories/duplicating-a-repository#mirroring-a-repository).

### Step 3

In the repository on GitHub, add this GitHub Actions workflow by adding a `mirror-sync.yml` file to `.github/workflows`:

```yml
name: Mirror Sync

on:
  workflow_dispatch:
  push:
  schedule:
    - cron: '*/5 * * * *'

jobs:
  mirror-sync:
    runs-on: ubuntu-latest

    steps:
      - name: Perform mirror sync
        uses: ActionsDesk/mirror-sync@main
        with:
          remote-repository-url: https://${{ secrets.REMOTE_AUTHENTICATION_TOKEN }}@example.com/remote-repository.git
```

If you want to authenticate to the remote repository via HTTPS and an authentication token, add it to the `remote-repository-url` as in the example above.
If you want to use basic authentication, you can pass the user and password like so:

```yml
remote-repository-url: https://${{ secrets.REMOTE_AUTHENTICATION_USER }}:${{ secrets.REMOTE_AUTHENTICATION_PASSWORD }}@example.com/remote-repository
```

If you want to use SSH for autentication, use an action that sets up the SSH key, unless you are using a self-hosted runner that already has SSH keys set up.
