local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
  ensure_installed = {
    "typescript", "javascript", "css", "html", "graphql", "tsx", "svelte", "scss", "prisma", "php", "markdown", "lua", "dockerfile", "yaml"
  },
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = {}, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
	},
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {
      "#618cdc",
      "#4cb3df",
      "#9e79ce",
      "#00a0b7",
      "#74aa49",
      "#cb994e",
      "#E06C75"
    }, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
	autopairs = {
		enable = true,
	},
  autotag = {
    enable = true,
    disable = { "xml", "markdown" },
  },
	indent = { enable = true, disable = { "yaml" } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.twig = {
  install_info = {
    url = "https://github.com/eirabben/tree-sitter-twig",
    files = {"src/parser.c", "src/scanner.cc"},
    branch = "main",
  },
  filetype = "twig",
}
