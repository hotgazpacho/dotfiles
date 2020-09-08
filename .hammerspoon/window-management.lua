-- Adapted from https://medium.com/@jhkuperus/window-management-with-hammerspoon-personal-productivity-c77adc436888
local This = {}

local COLUMNS = 12
local ROWS = 8

local HALF_WIDTH = COLUMNS / 2
local ONE_THIRD_WIDTH = COLUMNS / 3
local TWO_THIRDS_WIDTH = ONE_THIRD_WIDTH * 2
local ONE_QUARTER_WIDTH = COLUMNS / 4
local THREE_QUARTERS_WIDTH = ONE_QUARTER_WIDTH * 3

-- Set the grid size and remove margin
-- Also, don't animate window changes... That's too slow
hs.grid.setGrid(COLUMNS .. 'x' .. ROWS)
hs.grid.setMargins({0, 0})
hs.window.animationDuration = 0

local screenPositions = {}
screenPositions.leftHalf = {
  x = 0, y = 0,
  w = HALF_WIDTH, h = ROWS
}
screenPositions.rightHalf = {
  x = HALF_WIDTH, y = 0,
  w = HALF_WIDTH, h = ROWS
}
screenPositions.leftThird = {
  x = 0, y = 0,
  w = ONE_THIRD_WIDTH, h = ROWS
}
screenPositions.rightThird = {
  x = TWO_THIRDS_WIDTH, y = 0,
  w = ONE_THIRD_WIDTH, h = ROWS
}
screenPositions.leftTwoThirds = {
  x = 0, y = 0,
  w = TWO_THIRDS_WIDTH, h = ROWS
}
screenPositions.rightTwoThirds = {
  x = ONE_THIRD_WIDTH, y = 0,
  w = TWO_THIRDS_WIDTH, h = ROWS
}
screenPositions.centered = {
  x = ONE_QUARTER_WIDTH, y = 1,
  w = HALF_WIDTH, h = ROWS - 2
}

This.screenPositions = screenPositions

-- This function will move either the specified or the focuesd
-- window to the requested screen position
function This.moveWindowToPosition(cell, window)
  if window == nil then
    window = hs.window.focusedWindow()
  end
  if window then
    local screen = window:screen()
    hs.grid.set(window, cell, screen)
  end
end

-- Toggle full screen for the current app
function This.toggleFullscreen()
  local win = hs.window.frontmostWindow()
  win:setFullscreen(not win:isFullscreen())
end

return This