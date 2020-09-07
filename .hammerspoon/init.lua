-- A global variable for the Hyper Mode
local hyper = hs.hotkey.modal.new({}, nil)

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
hyper.pressed = function()
  hyper.triggered = false
  hyper:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
-- send ESCAPE if no other keys are pressed.
hyper.released = function()
  hyper:exit()
  if not hyper.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

hs.hotkey.bind({}, 'F18', hyper.pressed, hyper.released)

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

-- Toggle mic mute with statusbar display
local micMuteStatusMenu = hs.menubar.new()
-- Icons made by https://www.flaticon.com/authors/dmitri13 from https://www.flaticon.com
local micMutedIcon = hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/microphone-muted.png")
local micHotIcon = hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/microphone-hot.png")

function DisplayMicMuteStatus()
  local currentAudioInput = hs.audiodevice.current(true)
  local currentAudioInputObject = hs.audiodevice.findInputByUID(currentAudioInput.uid)
  Muted = currentAudioInputObject:inputMuted()
  if Muted then
    micMuteStatusMenu:setIcon(micMutedIcon)
  else
    micMuteStatusMenu:setIcon(micHotIcon)
  end
end

function ToggleMicMuteStatus()
  local currentAudioInput = hs.audiodevice.current(true)
  local currentAudioInputObject = hs.audiodevice.findInputByUID(currentAudioInput.uid)
  local isMuted = not Muted
  hs.alert.closeSpecific(MicAlert)
  if isMuted then
    -- hs.notify.new({title="Microphone", informativeText='Microphone is Muted', setIdImage=micMutedIcon}):send()
    MicAlert = hs.alert.show('Microphone is muted')
  else
    -- hs.notify.new({title="Microphone", informativeText='Microphone is HOT', setIdImage=micHotIcon}):send()
    MicAlert = hs.alert.show('Microphone is HOT')
  end
  currentAudioInputObject:setInputMuted(not Muted)
  DisplayMicMuteStatus()
end

-- Watch all the input devices to get changes to their statuses
for i,dev in ipairs(hs.audiodevice.allInputDevices()) do
  dev:watcherCallback(DisplayMicMuteStatus):watcherStart()
end
-- Display the current input status
DisplayMicMuteStatus()
-- Click the menu icon to toggle the status
micMuteStatusMenu:setClickCallback(ToggleMicMuteStatus)
-- Bind hyper space to toggle the status
hyper:bind({}, "space", function()
  ToggleMicMuteStatus()
  hyper.triggered = true
end)