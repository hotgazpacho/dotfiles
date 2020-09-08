local hyper = require('hyper')
local wm = require('window-management')
local micMute = require('mic-mute')
micMute:start()

-- lock the screen
hyper:bind({}, "l", function()
  hs.caffeinate.lockScreen()
  hyper.triggered = true
end)

-- hyper cmd s to toggle preventing the machine from sleeping
hyper:bind("cmd", "s", function()
  hs.caffeinate.toggle('system')
  hyper.triggered = true
end)

-- Bind hyper space to toggle the status
hyper:bind({}, "space", function()
  micMute.toggleStatus()
  hyper.triggered = true
end)

-- Window Management
hyper:bind({}, 'left', function()
  wm.moveWindowToPosition(wm.screenPositions.leftHalf)
  hyper.triggered = true
end)

hyper:bind({}, 'right', function()
  wm.moveWindowToPosition(wm.screenPositions.rightHalf)
  hyper.triggered = true
end)

hyper:bind('cmd', 'left', function()
  wm.moveWindowToPosition(wm.screenPositions.leftTwoThirds)
  hyper.triggered = true
end)

hyper:bind('cmd', 'right', function()
  wm.moveWindowToPosition(wm.screenPositions.rightTwoThirds)
  hyper.triggered = true
end)

hyper:bind('alt', 'left', function()
  wm.moveWindowToPosition(wm.screenPositions.leftThird)
  hyper.triggered = true
end)

hyper:bind('alt', 'right', function()
  wm.moveWindowToPosition(wm.screenPositions.rightThird)
  hyper.triggered = true
end)

hyper:bind({}, "return", function()
  wm.toggleFullscreen()
  hyper.triggered = true
end)

hyper:bind('shift', "return", function()
  wm.moveWindowToPosition(wm.screenPositions.centered)
  hyper.triggered = true
end)

hyper:bind('shift', 'up', function()
  hs.window.focusedWindow():moveOneScreenNorth()
  hyper.triggered = true
end)

hyper:bind('shift', 'down', function()
  hs.window.focusedWindow():moveOneScreenSouth()
  hyper.triggered = true
end)

hyper:bind('shift', 'left', function()
  hs.window.focusedWindow():moveOneScreenEast()
  hyper.triggered = true
end)

hyper:bind('shift', 'right', function()
  hs.window.focusedWindow():moveOneScreenWest()
  hyper.triggered = true
end)