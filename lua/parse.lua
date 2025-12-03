local KEYS = {
  NULL = 0,
  SPACE = 32,
  LEFT_BRACKET = 123,
  RIGHT_BRACKET = 125
}


local function parse_ws(file, row, i, j)
  while i <= row do
    while j <= #file[i] do
      local char_code = string.byte(file[i], j)
      if char_code == KEYS.SPACE then
      else
        return i, j            
      end
      j = j + 1
    end
    i = i + 1
  end
  return i, j
end

local function parse_manifest(file, pos)
  local row, col = unpack(pos)
  local ast = {}
  local suggestions = {}
  local i = 1
  local j = 1

  local function peek()
    if i == row and j == #file[i] then
      return KEYS.NULL
    end
    return string.byte(file[i], j)
  end

  local function end_of_parse()
    return peek() == KEYS.NULL
  end

  local function next()
    local ch = peek()
    if j == #file[i] then
      i = i + 1
      j = 1
    else 
      j = j + 1
    end
    return ch
  end

  -- handle whitespace
  i, j = parse_ws(file, row, i, j) 
  if end_of_parse() then
    return suggestions
  end
  if peek() ~= KEYS.LEFT_BRACKET then
    return suggestions
  else 
    -- parse LEFT_BRACKET
    next()
  end
  print("parse complete")
end


return {
  parse_manifest = parse_manifest
}
