local home = require'os'.getenv('HOME')

local function file_exists(name)
  local f=io.open(name,"r")
  if f~=nil then io.close(f) return true else return false end
end

-- check for local tags
if not file_exists(home .. '/.config/nvim/doc/tags') then
  local docsPath = home .. '/.config/nvim/doc'
  vim.cmd('helpt ' .. docsPath)
end

