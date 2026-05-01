# MLX Training Studio — install notes

Quick reference for installing and using [MLX Training Studio](https://github.com/stevenatkin/mlx-lm-gui)
via the [jsgermanaai/mlx-training-studio-installer](https://github.com/jsgermanaai/mlx-training-studio-installer).

## What it is

A native Swift macOS GUI by Steven Atkin that wraps `mlx-lm-lora` for LoRA/QLoRA
fine-tuning on Apple Silicon. The upstream project ships source only — the
installer scripts here clone it, build it with Xcode, and copy the `.app` to
`/Applications`.

## Requirements

| Requirement | Notes |
|---|---|
| macOS 13 (Ventura) or later | `sw_vers -productVersion` |
| Apple Silicon (arm64) | Intel is not supported by upstream |
| Full Xcode 15+ | Command Line Tools alone are not sufficient |
| Python 3.12+ | Not the `/usr/bin/python3` stub — `brew install python@3.12` |
| ~5 GB free disk | For source clone, build artifacts, model cache |

## Install

### One-time CLI install

```bash
brew install jsgermanaai/tap/mlx-training-studio
```

### Verify your environment

```bash
mlx-training-studio doctor
```

If `doctor` reports missing Xcode:

1. Install Xcode from the [Mac App Store](https://apps.apple.com/app/xcode/id497799835)
   (~10 GB, takes a while).
2. Switch the active developer directory:
   ```bash
   sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
   ```
3. Accept the license:
   ```bash
   sudo xcodebuild -license accept
   ```
4. Re-run `mlx-training-studio doctor` — it should pass.

### Build and install the app

```bash
mlx-training-studio install
```

This prompts for:
- Source directory (default: `~/Library/Application Support/MLX Training Studio/source`)
- Install location (`/Applications` or `~/Applications`)
- Optional git ref pin (default: track upstream `main`)

For unattended runs:
```bash
MLX_TS_NONINTERACTIVE=1 mlx-training-studio install
```

## Daily commands

| Command | What it does |
|---|---|
| `mlx-training-studio status` | Print install manifest (version, commit, paths) |
| `mlx-training-studio update` | Pull latest upstream, rebuild, replace `.app` |
| `mlx-training-studio uninstall` | Remove `.app`; prompt to remove source + manifest |
| `mlx-training-studio doctor` | Re-validate environment (no side effects) |

## Where things live

- Upstream source clone: `~/Library/Application Support/MLX Training Studio/source/`
- Install manifest: `~/Library/Application Support/MLX Training Studio/manifest.json`
- Installed app: `/Applications/MLX GUI.app`

## Troubleshooting

If macOS Gatekeeper blocks the locally-built app:
```bash
xattr -dr com.apple.quarantine "/Applications/MLX GUI.app"
```

Or right-click the app the first time → Open → confirm.

For everything else, see the
[installer's troubleshooting guide](https://github.com/jsgermanaai/mlx-training-studio-installer/blob/main/docs/TROUBLESHOOTING.md).

## Credits

The app itself is by [Steven Atkin](https://github.com/stevenatkin/mlx-lm-gui),
licensed Apache-2.0. The installer wrapper is independent and unaffiliated.
