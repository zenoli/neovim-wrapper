---@return table<string, string[]>
local function get_linters_by_ft()
  local linters_by_ft = {}
  for lang, module in pairs(require("lang").load()) do
    if module.lint then
      if vim.islist(module.lint) then
        linters_by_ft[lang] = module.lint
      else
        for ft, linters in pairs(module.lint) do
          linters_by_ft[ft] = linters
        end
      end
    end
  end
  return linters_by_ft
end

return { get_linters_by_ft = get_linters_by_ft }
