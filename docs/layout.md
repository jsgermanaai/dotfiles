# 🗂 Repository layout

```
dotfiles/
├── 📝 README.md                  ← project overview
├── 🍺 Brewfile                   ← brews + casks (fresh-machine spec)
├── 🛠 install.sh                 ← idempotent one-shot installer
├── 🍎 macos.sh                   ← macOS system defaults
├── 📑 mkdocs.yml                 ← this docs site
├── 🐚 zsh/
│   ├── .zshrc                    ← shell config + helpers
│   ├── .zprofile
│   └── starship.toml             ← multiline cobalt+magenta prompt
├── 📝 nvim/                      ← LazyVim
│   └── lua/plugins/
│       ├── colorscheme.lua       ← TokyoNight Storm overrides
│       ├── ai.lua                ← CodeCompanion → MLX/LM Studio
│       ├── go-development.lua
│       └── productivity.lua
├── 🪟 tmux/                      ← .tmux.conf + cheatsheet
├── 🐙 lazygit/config.yml         ← palette-matched theme
├── 🦇 bat/config                 ← TwoDark theme + MANPAGER hookup
├── 🔀 git/
│   ├── .gitconfig                ← delta pager + conventional commits
│   └── .gitconfig-auditidentity
├── 🔐 ssh/config
├── 📜 vim/.vimrc                 ← amix runtime loader
├── 🧰 scripts/setup-dev-session.sh
└── 📸 docs/
    ├── *.md                      ← mkdocs site source
    ├── stylesheets/cobalt.css    ← cobalt + magenta palette CSS
    └── screenshots/              ← README + site assets
        └── generate.sh           ← regenerate every screenshot
```
