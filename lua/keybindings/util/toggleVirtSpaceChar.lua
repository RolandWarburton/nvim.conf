-- toggle the space virtual text
function Toggle_listchar()
  local listchars = vim.opt.listchars:get()
  if listchars.space == Listchars.space then
    vim.opt.listchars:append({ space = " " })
  else
    vim.opt.listchars = Listchars
  end
end
