-- Go development configuration for LazyVim
return {
  -- Import Go language support
  { import = "lazyvim.plugins.extras.lang.go" },

  -- Enhanced Go tooling
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup({
        -- Go formatting and imports
        gofmt = "gopls",
        goimports = "gopls",
        fillstruct = "gopls",
        -- Test configuration
        test_runner = "go",
        -- LSP configuration
        lsp_cfg = true,
        lsp_gofumpt = true,
        lsp_on_attach = true,
        lsp_keymaps = true,
        -- Diagnostics
        diagnostic = {
          hdlr = false,
          underline = true,
          virtual_text = { space = 0, prefix = "" },
          signs = true,
          update_in_insert = false,
        },
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },

  -- Kubernetes YAML support
  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
      local cfg = require("yaml-companion").setup({
        -- Built in file matchers
        builtin_matchers = {
          kubernetes = { enabled = true },
          docker_compose = { enabled = true },
        },
        -- Additional schemas
        schemas = {
          {
            name = "Kubernetes",
            uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json",
          },
        },
        lspconfig = {
          flags = {
            debounce_text_changes = 150,
          },
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              validate = true,
              format = { enable = true },
              hover = true,
              schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/api/json/catalog.json",
              },
              schemas = {
                kubernetes = "*.yaml",
                ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
                ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
                ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
                ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
                ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
                ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
                ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
                ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
              },
            },
          },
        },
      })
      require("lspconfig")["yamlls"].setup(cfg)
    end,
    ft = { "yaml" },
  },

  -- Docker support
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        dockerls = {},
        docker_compose_language_service = {},
      },
    },
  },

  -- Enhanced LSP configuration for Go
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-server", "-node_modules" },
              semanticTokens = true,
            },
          },
        },
      },
    },
  },

  -- Treesitter configuration for Go and other languages
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "go",
        "gomod",
        "gowork",
        "gosum",
        "yaml",
        "json",
        "dockerfile",
        "bash",
        "lua",
        "markdown",
        "markdown_inline",
        "vim",
        "vimdoc",
        "query",
      },
    },
  },

  -- Mason tool installations
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Go tools
        "gopls",
        "gofumpt",
        "goimports",
        "golines",
        "golangci-lint",
        "gotests",
        "gotestsum",
        "govulncheck",
        -- YAML/Kubernetes tools
        "yaml-language-server",
        "yamllint",
        "yq",
        -- Docker tools
        "dockerfile-language-server",
        "hadolint",
        -- Shell tools
        "bash-language-server",
        "shellcheck",
        "shfmt",
        -- Lua tools
        "lua-language-server",
        "stylua",
        -- General tools
        "prettier",
        "markdownlint",
      },
    },
  },
}
