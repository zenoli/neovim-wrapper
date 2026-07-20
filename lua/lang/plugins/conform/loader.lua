---@return table<string, string[]>
local function get_formatters_by_ft()
  local formatters_by_ft = {}
  for lang, module in pairs(require("lang").load()) do
    if module.format then
      if vim.islist(module.format) then
        formatters_by_ft[lang] = module.format
      else
        for ft, formatters in pairs(module.format) do
          formatters_by_ft[ft] = formatters
        end
      end
    end
  end
  return formatters_by_ft
end

return { get_formatters_by_ft = get_formatters_by_ft }
