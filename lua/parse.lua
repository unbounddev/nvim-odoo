local SPACE = 32;
local LEFT_BRACKET = 123;
local RIGHT_BRACKET = 125;

local function parse_ws(file, row, i, j)
  while i <= row do
    while j <= #file[i] do
      local char_code = string.byte(file[i], j)
      if char_code == SPACE then
      else
        return i, j            
      end
      j = j + 1
    end
    i = i + 1
  end
end

local function parse_manifest(file, pos)
  local row, col = unpack(pos)
  local ast = {}
  local i = 1
  local j = 1

  while i <= row do 
    j = 1
    while j <= #file[i] do
      -- handle whitespace
      i, j = parse_ws(file, row, i, j) 
      if string.byte(file[i], j) ~= LEFT_BRACKET then
        return ast
      end
      j = j + 1 
    end
    i = i + 1
  end
  print("parse complete")
end


return {
  parse_manifest = parse_manifest
}
