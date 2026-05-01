# 🐳 Colima — on-demand Docker / Kubernetes

[Colima](https://github.com/abiosoft/colima) is a lightweight Linux VM that
provides a Docker daemon (and optionally k3s) on macOS — without Docker Desktop.

The default policy here is **on-demand**: don't burn 4–8 GB of RAM on a VM you
aren't using. Helpers in `~/.zshrc` start, stop, and inspect the VM, and the
**starship prompt shows a 🐳 indicator whenever the VM is running** so you never
forget it's eating resources in the background.

!!! info "Prompt indicator"
    ```
    ╭─  ~/work/myproject  on   main  🐳
    │
    ╰─❯
    ```
    The 🐳 is a `[custom.colima]` segment defined in
    [`zsh/starship.toml`](https://github.com/your-user/dotfiles/blob/main/zsh/starship.toml).
    It checks `~/.colima/default/docker.sock` (a `stat()` call, microseconds)
    on every prompt.

## Helpers

| Command | What it does |
|---------|--------------|
| `colima-start` | Boot the VM with your configured CPU/memory/disk. No-op if already running. |
| `colima-stop` | Shut it down. |
| `colima-restart` | Stop, then start. |
| `colima-status` | Print the runtime, address, arch, and (if enabled) k8s status. |
| `colima-ssh` | SSH into the VM (handy for debugging mounts/networking). |
| `colima-nuke` | **Destructive.** Delete the VM entirely. Asks for `y/N` confirmation. |

Plus convenience aliases:

```bash
dps      # docker ps with a clean format
dimg     # docker images
dprune   # docker system prune -af --volumes
```

## Tunables

Override these in `~/.zshrc.local` (gitignored). Defaults are conservative for a
laptop:

```bash
export COLIMA_CPU=4        # CPU cores
export COLIMA_MEM=8        # memory in GB
export COLIMA_DISK=60      # disk in GB
export COLIMA_K8S=false    # set to "true" to start k3s alongside Docker
```

Restart the VM after changing these:

```bash
colima-restart
```

## Recipes

=== "Start with Kubernetes"

    Set `COLIMA_K8S=true` (in `~/.zshrc.local` for permanence, or just for one
    shell), then start:

    ```bash
    COLIMA_K8S=true colima-start
    kubectl config use-context colima
    kubectl get nodes
    ```

=== "Bigger VM for heavy workloads"

    ```bash
    # In ~/.zshrc.local
    export COLIMA_CPU=8
    export COLIMA_MEM=16
    export COLIMA_DISK=120
    ```

    Then `colima-restart` to apply.

=== "Switch between Docker contexts"

    Colima registers a `colima` Docker context automatically. Switch back to
    the default (e.g., Docker Desktop) with:

    ```bash
    docker context use default     # back to Docker Desktop / system
    docker context use colima      # back to colima
    ```

=== "VM got into a weird state"

    Sometimes the VM dies mid-shutdown or networking jams. Nuke and restart:

    ```bash
    colima-nuke      # asks y/N, deletes the VM
    colima-start
    ```

    Containers and images are gone — you're starting clean.

## Hide the prompt indicator

If the 🐳 is too noisy, disable the custom segment:

```toml
# In zsh/starship.toml
[custom.colima]
disabled = true
```

Or remove `${custom.colima}` from the `format` string entirely.

## Troubleshooting

!!! warning "Permission denied connecting to Docker socket"
    Run `colima status` — if it says "stopped," start it. If running but you
    still can't reach the socket, your `DOCKER_HOST` may be pointing elsewhere.
    Try:
    ```bash
    unset DOCKER_HOST
    docker context use colima
    ```

!!! warning "Slow first boot"
    Cold start downloads the Lima ubuntu image (~500 MB) the first time.
    Subsequent boots are 3–10 seconds.

!!! warning "Prompt feels laggy after `colima-start`"
    The detection (`stat` on the docker socket) is microseconds, so the
    indicator itself isn't the cause. If your prompt feels slow, profile with
    `STARSHIP_LOG=trace starship explain`.
