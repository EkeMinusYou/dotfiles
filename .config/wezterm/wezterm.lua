local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local _, _, window = mux.spawn_window({})
	window:gui_window():toggle_fullscreen()
end)

return {
	color_scheme = "Afterglow",
	window_close_confirmation = "NeverPrompt",
	native_macos_fullscreen_mode = true,
	hide_tab_bar_if_only_one_tab = true,
	use_ime = true,

	font = wezterm.font("HackGen35 Console NF"),
	font_size = 12.0,

	inactive_pane_hsb = {
		saturation = 0.5,
		brightness = 0.8,
	},

	audible_bell = "Disabled",

	keys = {
		{ key = "n", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },
		{ key = "p", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },

		{ key = "v", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "s", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

		{ key = "c", mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = true }) },

		{ key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
		{ key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
		{ key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
		{ key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },

		{ key = "h", mods = "CTRL|SHIFT|ALT", action = act.AdjustPaneSize({ "Left", 10 }) },
		{ key = "l", mods = "CTRL|SHIFT|ALT", action = act.AdjustPaneSize({ "Right", 10 }) },
		{ key = "k", mods = "CTRL|SHIFT|ALT", action = act.AdjustPaneSize({ "Up", 5 }) },
		{ key = "j", mods = "CTRL|SHIFT|ALT", action = act.AdjustPaneSize({ "Down", 5 }) },
	},
}
