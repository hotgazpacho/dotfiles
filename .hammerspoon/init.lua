-- watch for changes under ~/.hammerspoon and reload
local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon", hs.reload)
myWatcher:start()

hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall.repos.ShiftIt = {
   url = "https://github.com/peterklijn/hammerspoon-shiftit",
   desc = "ShiftIt spoon repository",
   branch = "master",
}

spoon.SpoonInstall:andUse("ShiftIt", { repo = "ShiftIt" })

local hyperChord = {'cmd','alt','shift','ctrl'}
local mehChord = {'alt','shift','ctrl'}

spoon.ShiftIt:bindHotkeys({
   left = {hyperChord, 'left' },
   right = {hyperChord, 'right' },
   up = {hyperChord, 'up' },
   down = {hyperChord, 'down' },
   upleft = {hyperChord, '1' },
   upright = {hyperChord, '2' },
   botleft = {hyperChord, '3' },
   botright = {hyperChord, '4' },
   maximum = {hyperChord, 'm' },
   toggleFullScreen = {hyperChord, 'f' },
   toggleZoom = {hyperChord, 'z' },
   center = {hyperChord, 'c' },
   nextScreen = {hyperChord, 'n' },
   previousScreen = {hyperChord, 'p' },
   resizeOut = {hyperChord, '=' },
   resizeIn = {hyperChord, '-' }
 }
)

local caffeine = require('caffeine')
caffeine:start()

-- local micMute = require('mic-mute')
-- micMute:start()

--local hyper = require('hyper')

-- lock the screen
hs.hotkey.bind(mehChord, "L", function()
   hs.caffeinate.lockScreen()
end)

-- toggle preventing the machine from sleeping
hs.hotkey.bind(mehChord, "c", function()
   caffeine.toggle()
end)

-- toggle mice mute
hs.hotkey.bind(mehChord, "m", function()
   micMute.toggleStatus()
end)
