local MicMute = {}

-- Toggle mic mute with statusbar display
local statusMenu = hs.menubar.new()
-- Icons made by https://www.flaticon.com/authors/dmitri13 from https://www.flaticon.com
local micMutedIcon = hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/microphone-muted.png")
local micHotIcon = hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/microphone-hot.png")

function MicMute.displayStatus()
  local currentAudioInput = hs.audiodevice.current(true)
  local currentAudioInputObject = hs.audiodevice.findInputByUID(currentAudioInput.uid)
  MicMute.muted = currentAudioInputObject:inputMuted()
  if MicMute.muted then
    statusMenu:setIcon(micMutedIcon)
  else
    statusMenu:setIcon(micHotIcon)
  end
end

function MicMute.toggleStatus()
  local currentAudioInput = hs.audiodevice.current(true)
  local currentAudioInputObject = hs.audiodevice.findInputByUID(currentAudioInput.uid)
  local isMuted = not MicMute.muted
  hs.alert.closeSpecific(MicAlert)
  if isMuted then
    -- hs.notify.new({title="Microphone", informativeText='Microphone is Muted', setIdImage=micMutedIcon}):send()
    MicAlert = hs.alert.show('Microphone is muted')
  else
    -- hs.notify.new({title="Microphone", informativeText='Microphone is HOT', setIdImage=micHotIcon}):send()
    MicAlert = hs.alert.show('Microphone is HOT')
  end
  currentAudioInputObject:setInputMuted(not MicMute.muted)
  MicMute.displayStatus()
end

function MicMute.start()
  -- Watch all the input devices to get changes to their statuses
  for i,dev in ipairs(hs.audiodevice.allInputDevices()) do
    dev:watcherCallback(nil):watcherCallback(MicMute.displayStatus):watcherStart()
  end
  -- Display the current input status
  MicMute.displayStatus()
  -- Click the menu icon to toggle the status
  statusMenu:setClickCallback(MicMute.toggleStatus)
end

return MicMute