local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local window_width_limit = 70

local hide_in_width = function()
  return vim.fn.winwidth(0) > window_width_limit
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local lsp = {
  function(msg)
    msg = msg or "LS Inactive"
    local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
      if type(msg) == "boolean" or #msg == 0 then
        return "LS Inactive"
      end
      return msg
    end
    local buf_client_names = {}

    -- add client
    for _, client in pairs(buf_clients) do
      if client.name ~= "null-ls" then
        table.insert(buf_client_names, client.name)
      end
    end

    local unique_client_names = vim.fn.uniq(buf_client_names)
    return "[" .. table.concat(unique_client_names, ", ") .. "]"
  end,
  color = { gui = "bold" },
  cond = hide_in_width
}

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { "alpha", "dashboard", "NvimTree" },
  },
  sections = {
    lualine_a = { { " ", padding = { left = 0, right = 0 }, color = {}, cond = nil } },
    lualine_b = {
      {
        "b:gitsigns_head", icon = " ",
        color = { gui = "bold" },
        cond = hide_in_width
      },
      {
        "filename",
        color = {},
        cond = nil,
      }
    },
    lualine_c = {
      {
        "diff",
        source = diff_source,
        symbols = { added = " ", modified = " ", removed = " " },
        diff_color = {
          added = { fg = "#90d15a" },
          modified = { fg = "#e9ad5a" },
          removed = { fg = "#f16372" },
        },
        cond = nil,
      }
    },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", warn = " ", info = " ", hint = " " },
        cond = hide_in_width
      },
      {
        function()
          local b = vim.api.nvim_get_current_buf()
          if next(vim.treesitter.highlighter.active[b]) then
            return ""
          end
          return ""
        end,
        color = { fg = "#90d15a" },
        cond = hide_in_width
      },
      lsp,
      {
        "filetype",
        cond = hide_in_width
      }
    },
    lualine_y = {},
    lualine_z = { {
      function()
        local current_line = vim.fn.line "."
        local total_lines = vim.fn.line "$"
        local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
        local line_ratio = current_line / total_lines
        local index = math.ceil(line_ratio * #chars)
        return chars[index]
      end,
      padding = { left = 0, right = 0 },
      color = { fg = "#8fcf59", bg = "#16161f" },
      cond = nil
    } }
  },
  inactive_sections = {
    lualine_a = {
      "filename",
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = { "nvim-tree" }
}
