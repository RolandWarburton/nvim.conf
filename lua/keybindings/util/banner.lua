local M = {}

M.banner_char = "#"

-- Returns fill (border repeat char) and cap (middle line end-cap string).
local function get_comment_chars()
  local cs = vim.bo.commentstring
  if cs and cs ~= "" then
    local prefix = cs:match("^%s*(.-)%s*%%s")
    if prefix and prefix ~= "" then
      if prefix == "//" then return "-", "//" end
      return prefix:sub(#prefix, #prefix), prefix
    end
  end
  return M.banner_char, M.banner_char
end

local function make_banner_lines(word)
  local fill, cap = get_comment_chars()
  local cap_len = #cap
  local strlen = #word
  local strspace = math.min(math.floor(strlen / 2), 5)
  -- decorative: cap uses a different character than fill (e.g. // vs -), so inner
  -- dashes make sense. Exempt cases like -- where cap chars are the same as fill.
  local decorative = cap:sub(1, 1) ~= fill
  local use_caps = strlen > 2 or cap ~= fill

  local border, middle

  if decorative then
    local fill_pad = math.max(2, strspace - 1)
    middle = cap .. string.rep(fill, fill_pad) .. " " .. word .. " " .. string.rep(fill, fill_pad)
    border = cap .. string.rep(fill, #middle - cap_len)
  elseif use_caps then
    local width = strspace + strlen + strspace
    if width - strlen - 2 * cap_len < 2 then width = strlen + 2 * cap_len + 2 end
    if (width - strlen - 2 * cap_len) % 2 ~= 0 then width = width + 1 end
    local pad = string.rep(" ", (width - strlen - 2 * cap_len) / 2)
    middle = cap .. pad .. word .. pad .. cap
    border = cap .. string.rep(fill, width - cap_len)
  else
    local width = strspace + strlen + strspace
    if width < strlen + 2 then width = strlen + 2 end
    if (width - strlen) % 2 ~= 0 then width = width + 1 end
    local pad_l = math.floor((width - strlen) / 2)
    middle = string.rep(" ", pad_l) .. word .. string.rep(" ", width - strlen - pad_l)
    border = string.rep(fill, width)
  end

  return { border, middle, border }
end

-- Returns 0-indexed start row and extracted word if cursor is inside a banner, else nil.
local function find_banner_at_cursor()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local n = #lines
  local fill, cap = get_comment_chars()

  local function is_border(r)
    if r < 1 or r > n then return false end
    local line = lines[r]
    local rest = #line - #cap
    return rest > 0 and line == cap .. string.rep(fill, rest)
  end

  local top
  if is_border(row) then
    if is_border(row + 2) then
      top = row
    elseif is_border(row - 2) then
      top = row - 2
    end
  elseif is_border(row - 1) and is_border(row + 1) then
    top = row - 1
  end

  if not top then return nil end

  local mid = lines[top + 1]
  local ec = vim.pesc(cap)
  local ef = vim.pesc(fill)
  local word = mid:match("^" .. ec .. "[" .. ef .. "%s]*(.-)%s*[" .. ef .. "%s]*" .. ec .. "$")
    or mid:match("^" .. ec .. "?%s*(.-)%s*" .. ec .. "?$")
    or ""
  return top - 1, word
end

function M.insert_banner()
  local start_row, existing = find_banner_at_cursor()
  local word = tostring(vim.fn.input("Banner: ", existing or ""))
  if word == "" then return end
  if start_row then
    vim.api.nvim_buf_set_lines(0, start_row, start_row + 3, false, make_banner_lines(word))
  else
    local row = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, make_banner_lines(word))
  end
end

return M
