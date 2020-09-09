local Caffeine = {}

Caffeine.statusMenu = hs.menubar.new()
-- Icons made by https://www.flaticon.com/authors/freepik from https://www.flaticon.com/
local onIcon = hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/caffeine-on.png")
local offIcon = hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/caffeine-off.png")

local sleepType = 'systemIdle'
local caffeineAlert = nil

function Caffeine.displayStatus()
  local prevented = hs.caffeinate.get(sleepType)
  if (prevented) then
    Caffeine.statusMenu:setIcon(onIcon)
  else
    Caffeine.statusMenu:setIcon(offIcon)
  end
end

function Caffeine.toggle()
  hs.alert.closeSpecific(caffeineAlert)
  local prevented = hs.caffeinate.toggle(sleepType)
  if (prevented) then
    caffeineAlert = hs.alert.show('CAFFEINEATE!!!')
  else
    caffeineAlert = hs.alert.show('Simmer down now!')
  end
  Caffeine.displayStatus()
end

function Caffeine.start()
  Caffeine.displayStatus()
  Caffeine.statusMenu:setClickCallback(Caffeine.toggle)
end

return Caffeine