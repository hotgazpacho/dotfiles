-- A global variable for the Hyper Mode
local hyper = hs.hotkey.modal.new({}, nil)

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
hyper.pressed = function()
  hyper.triggered = false
  hyper:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
-- send ESCAPE if no other keys are pressed.
-- When binding a new key combo, it is important to call hyper.triggered = true
-- In order to prevent sending an extra esc key stroke
hyper.released = function()
  hyper:exit()
  if not hyper.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

hs.hotkey.bind({}, 'F18', hyper.pressed, hyper.released)

return hyper