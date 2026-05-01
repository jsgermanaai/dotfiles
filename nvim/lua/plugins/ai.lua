-- AI assist via a local LLM server (Gemma 3 MoE on MLX or LM Studio).
-- On-demand: start the server yourself before invoking the plugin.
--   mlx_lm.server  →  `mlx-start`  (default port 8080)
--   LM Studio      →  start the local server in the app  (default port 1234)
-- The endpoint is picked from the AI_LLM_URL env var, defaulting to mlx_lm.server.
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions", "CodeCompanionCmd" },
    opts = {
      adapters = {
        local_llm = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            env = {
              url      = vim.env.AI_LLM_URL or "http://127.0.0.1:8080",
              api_key  = "LOCAL_LLM",
              chat_url = "/v1/chat/completions",
            },
            schema = {
              model = {
                default = vim.env.AI_LLM_MODEL or "gemma-3-moe",
              },
              num_ctx     = { default = 8192 },
              temperature = { default = 0.3 },
            },
          })
        end,
      },
      strategies = {
        chat   = { adapter = "local_llm" },
        inline = { adapter = "local_llm" },
        cmd    = { adapter = "local_llm" },
      },
      display = {
        chat = {
          window = {
            layout   = "vertical",
            position = "right",
            width    = 0.35,
          },
          show_settings = false,
        },
        diff = {
          provider = "default",
        },
      },
      opts = {
        log_level = "ERROR",
      },
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI Chat",    mode = { "n", "v" } },
      { "<leader>ai", "<cmd>CodeCompanion<cr>",            desc = "AI Inline",  mode = { "n", "v" } },
      { "<leader>ae", "<cmd>CodeCompanionActions<cr>",     desc = "AI Actions", mode = { "n", "v" } },
      { "<leader>aA", "<cmd>CodeCompanionChat Add<cr>",    desc = "AI Add to Chat", mode = "v" },
    },
    init = function()
      -- Register the <leader>a group with which-key
      local ok, wk = pcall(require, "which-key")
      if ok then
        wk.add({ { "<leader>a", group = "ai" } })
      end
    end,
  },
}
