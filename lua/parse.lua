local KEYS = {
  NULL = 0,
  SPACE = 32,
  DOUBLE_QUOTE = 34,
  SINGLE_QUOTE = 39,
  LEFT_BRACKET = 123,
  RIGHT_BRACKET = 125
}



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

  local function parse_ws()
    while i <= row do
      while j <= #file[i] do
        local char_code = string.byte(file[i], j)
        if char_code == KEYS.SPACE then
        else
          return             
        end
        j = j + 1
      end
      i = i + 1
    end
  end

  local function parse_string()
    return false
  end

  local function parse_entry()
    while i <= row do 
      while j <= #file[i] do
        -- handle whitespace
        parse_ws()
        if end_of_parse() then
          return
        end
        -- parse option/key
        local char = peek()
        if char == KEYS.DOUBLE_QUOTE or char == KEYS.SINGLE_QUOTE then
          local option = parse_string()
          if not option then
            return false
          end
        end
      end
    end
  end

  -- handle whitespace
  parse_ws() 
  if end_of_parse() then
    return suggestions
  end

  -- handle left bracket
  if peek() ~= KEYS.LEFT_BRACKET then
    return suggestions
  else 
    -- parse LEFT_BRACKET
    next()
    table.insert(ast, { entries = {} }) 
  end

  -- parse entries
  repeat
  until end_of_parse() or not parse_entry()
  print("parse complete")
end


return {
  parse_manifest = parse_manifest
}
