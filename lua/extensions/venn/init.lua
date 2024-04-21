local venn = require("venn")
local M = {}

function M.setup()
  venn.set_line({ "s", "s", " ", " " }, '|')
  venn.set_line({ " ", "s", " ", "s" }, '+')
  venn.set_line({ "s", " ", " ", "s" }, '+')
  venn.set_line({ " ", "s", "s", " " }, '+')
  venn.set_line({ "s", " ", "s", " " }, '+')
  venn.set_line({ " ", "s", "s", "s" }, '+')
  venn.set_line({ "s", " ", "s", "s" }, '+')
  venn.set_line({ "s", "s", " ", "s" }, '+')
  venn.set_line({ "s", "s", "s", " " }, '+')
  venn.set_line({ " ", " ", "s", "s" }, '-')
  venn.set_arrow("up", '^')
  venn.set_arrow("down", 'v')
  venn.set_arrow("left", '<')
  venn.set_arrow("right", '>')
end

return M
