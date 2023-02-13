local M = {}

function M.setup()
	local terminal = require("toggleterm")
	terminal.setup{
		size = function(term)
    	if term.direction == "horizontal" then
      	return 15
    	elseif term.direction == "vertical" then
      	return vim.o.columns * 0.4
    	end
  	end,
	}
end

return M
