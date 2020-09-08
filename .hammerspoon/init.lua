local hyper = require('hyper')
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

-- Toggle full screen for the current app
hyper:bind({}, "return", function()
  local win = hs.window.frontmostWindow()
  win:setFullscreen(not win:isFullscreen())
  hyper.triggered = true
end)

-- Bind hyper space to toggle the status
hyper:bind({}, "space", function()
  micMute.toggleStatus()
  hyper.triggered = true
end)