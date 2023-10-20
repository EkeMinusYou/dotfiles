local ime = {}

IME_AUTO_ENABLE = 0
ime.toggle_ime_auto_enable = function()
  if IME_AUTO_ENABLE == 0 then
    IME_AUTO_ENABLE = 1
  else
    IME_AUTO_ENABLE = 0
  end
end

return ime
