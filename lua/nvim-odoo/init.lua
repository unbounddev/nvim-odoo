local printUtils = require("table-utils")
local cmp = require("cmp")
local parse = require("parse")
local source = {}


function source:complete(params, callback)
  -- local file = io.open("debug.txt", "w")
  -- io.output(file)
  -- printUtils.printTable(params)
  -- io.close(file)
  -- local buffer_content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), "\n")
  print(buffer_content[row])
  local items = {}
  local ft = params.context.filetype
  local curr_file = vim.api.nvim_buf_get_name(0)
  if not string.find(curr_file, "__manifest__.py") then
    return
  end
  local buffer_content = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  parse.parse_manifest(buffer_content, vim.api.nvim_win_get_cursor(0))
  local cursor_before_line = params.context.cursor_before_line
  local trigger_character = params.completion_context.triggerCharacter
  if (trigger_character == "\"" or trigger_character == "'") and string.find(cursor_before_line, "^%s*[\"\']$") then
    items = {
      { 
        label = "name",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "version", 
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "description",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "author",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "website",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "license",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "category",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "depends",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "data",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "demo",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "auto_install",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "external_dependencies",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "application",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "assets",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "installable",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "maintainer",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "pre_init_hook",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "post_init_hook",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "uninstall_hook",
        kind = cmp.lsp.CompletionItemKind.Field
      },
      { 
        label = "active",
        kind = cmp.lsp.CompletionItemKind.Field
      }
    }
  end
  callback(items)
end

function source:get_trigger_characters()
  return { "\"", "'" }
end

source.new = function()
	return setmetatable({}, { __index = source })
end

return source
