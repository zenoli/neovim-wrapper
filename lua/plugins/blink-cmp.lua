return {
  {
    "colorful-menu.nvim",
    on_plugin = { "blink.cmp" },
  },
  {
    "blink.cmp",
    event = "DeferredUIEnter",
    after = function(_)
      require("blink.cmp").setup({
        keymap = { preset = 'default' },
        completion = {
          menu = {
            draw = {
              -- We don't need label_description now because label and label_description are already
              -- combined together in label by colorful-menu.nvim.
              columns = { { "kind_icon" }, { "label", gap = 1 } },
              components = {
                label = {
                  text = function(ctx)
                    return require("colorful-menu").blink_components_text(ctx)
                  end,
                  highlight = function(ctx)
                    return require("colorful-menu").blink_components_highlight(ctx)
                  end,
                },
              },
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
          }
        },
        cmdline = {
          completion = {
            menu = {
              auto_show = true,
            },
          },
          sources = function()
            local type = vim.fn.getcmdtype()
            -- Search forward and backward
            if type == '/' or type == '?' then return { 'buffer' } end
            -- Commands
            if type == ':' or type == '@' then return { 'cmdline' } end
            return {}
          end,
        },
        signature = {
          enabled = true,
          window = {
            show_documentation = true,
          },
        },
      })
    end,
  }
}
