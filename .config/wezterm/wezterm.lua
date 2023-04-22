local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local _, _, window = mux.spawn_window({})
	window:gui_window():toggle_fullscreen()
end)

return {
	color_scheme = "OneHalfDark",
	window_close_confirmation = "NeverPrompt",
	native_macos_fullscreen_mode = true,
	hide_tab_bar_if_only_one_tab = true,
	use_ime = true,
	font = wezterm.font("HackGen35 Console NFJ"),
	font_size = 16.0,
}
