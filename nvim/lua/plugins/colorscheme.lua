-- TokyoNight Storm, customised toward neon cobalt + magenta on pure black.
-- Palette stays internally consistent with starship + tmux for one-screen harmony.
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
      transparent = false,
      terminal_colors = true,
      styles = {
        comments  = { italic = true },
        keywords  = { italic = false, bold = true },
        functions = { bold = true },
        variables = {},
        sidebars  = "dark",
        floats    = "dark",
      },
      on_colors = function(c)
        -- Pure black backgrounds across the board, slight raise on floats
        c.bg            = "#000000"
        c.bg_dark       = "#000000"
        c.bg_float      = "#0a0a14"
        c.bg_popup      = "#0a0a14"
        c.bg_sidebar    = "#000000"
        c.bg_statusline = "#0a0a14"
        c.bg_visual     = "#1a1a3e"

        -- Cobalt blue family (primary)
        c.blue   = "#2D5BFF"
        c.blue0  = "#1e3a8a"
        c.blue1  = "#2D5BFF"
        c.blue2  = "#3b82f6"
        c.blue5  = "#60a5fa"
        c.blue6  = "#93c5fd"
        c.blue7  = "#0050E0"

        -- Magenta accents
        c.magenta  = "#FF1FE7"
        c.magenta2 = "#D670D6"
        c.purple   = "#c0a3ff"

        -- Status / diagnostics tuned for neon vibe
        c.green  = "#22EE99"
        c.cyan   = "#22D3EE"
        c.yellow = "#F5C542"
        c.orange = "#F59E0B"
        c.red    = "#FF4D4D"
        c.fg     = "#e0e0ee"
      end,
      on_highlights = function(hl, c)
        -- Line numbers: dim grey, magenta on cursor line
        hl.LineNr        = { fg = "#444466" }
        hl.CursorLineNr  = { fg = c.magenta, bold = true }
        hl.CursorLine    = { bg = "#0a0a14" }

        -- Search / visual feel neon
        hl.Search        = { fg = "#000000", bg = c.magenta, bold = true }
        hl.IncSearch     = { fg = "#000000", bg = c.yellow,  bold = true }
        hl.Visual        = { bg = "#1a1a3e" }

        -- Git signs
        hl.GitSignsAdd     = { fg = c.green }
        hl.GitSignsChange  = { fg = c.blue }
        hl.GitSignsDelete  = { fg = c.red }

        -- Make keywords + functions pop
        hl["@keyword"]          = { fg = c.magenta, bold = true }
        hl["@keyword.function"] = { fg = c.magenta, bold = true }
        hl["@function"]         = { fg = c.blue,    bold = true }
        hl["@function.call"]    = { fg = c.blue }
        hl["@type"]             = { fg = c.cyan }
        hl["@string"]           = { fg = c.green }

        -- Pickers / floats: subtle magenta border
        hl.FloatBorder        = { fg = c.magenta, bg = c.bg_float }
        hl.TelescopeBorder    = { fg = c.magenta, bg = c.bg_float }
        hl.TelescopePromptBorder = { fg = c.magenta, bg = c.bg_float }

        -- Diagnostics
        hl.DiagnosticError = { fg = c.red }
        hl.DiagnosticWarn  = { fg = c.orange }
        hl.DiagnosticInfo  = { fg = c.cyan }
        hl.DiagnosticHint  = { fg = c.magenta }
      end,
    },
  },

  -- Tell LazyVim to use it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-storm",
    },
  },
}
