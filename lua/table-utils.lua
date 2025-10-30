local format = string.format
local rep = string.rep
local write = io.write

-- Recursively print the table, if not table value is just printed
-- @param t any
-- @param level? number
local function printTable(t, level)
  level = level or 0
  if type(t) == "table" then
    -- do not print new line on the level 0
    if level ~= 0 then
      write("\n")
    end
    write(rep("\t", level), "{\n")
    level = level + 1

    for key, value in pairs(t) do
      write(rep("\t", level) .. format("[%s] = ", key))
      printTable(value, level)
      write(",\n")
    end

    level = level - 1
    write(rep("\t", level), "}")
  else
    write(tostring(t))
  end
  -- print new line on the level 0
  if level == 0 then
    write("\n")
  end
end

return {
  printTable = printTable,
}
