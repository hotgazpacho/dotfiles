local MicMute = {}

-- Toggle mic mute with statusbar display
local statusMenu = hs.menubar.new()
-- Icons made by https://www.flaticon.com/authors/dmitri13 from https://www.flaticon.com
local micMutedIcon = hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/microphone-muted.png")
local micHotIcon = hs.image.imageFromPath(os.getenv("HOME") .. "/.hammerspoon/microphone-hot.png")

-- The function is called by watcherCallback, which triggers on every input event
-- Therefor, you need to filter on the event and scope
function DisplayStatus(uid, event, scope)
  if (scope ~= 'inpt' and event ~= 'mute') then
    return
  end
  if (uid == nil) then
    local currentAudioInput = hs.audiodevice.current(true)
    uid = currentAudioInput.uid
  end
  local currentAudioInputObject = hs.audiodevice.findInputByUID(uid)
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
  DisplayStatus(currentAudioInput.uid, 'mute', 'inpt')
end

function MicMute.start()
  -- Watch all the input devices to get changes to their statuses
  for i,dev in ipairs(hs.audiodevice.allInputDevices()) do
    dev:watcherCallback(nil):watcherCallback(DisplayStatus):watcherStart()
  end
  -- Display the current input status
  DisplayStatus(nil, 'mute', 'inpt')
  -- Click the menu icon to toggle the status
  statusMenu:setClickCallback(MicMute.toggleStatus)
end

return MicMute