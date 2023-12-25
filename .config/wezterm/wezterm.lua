local wezterm = require("wezterm")
local act = wezterm.action

return {
	color_scheme = "kanagawabones",
	tab_bar_at_bottom = true,
	window_decorations = "RESIZE | MACOS_FORCE_ENABLE_SHADOW",
	window_background_opacity = 0.9,
	macos_window_background_blur = 9,
	window_close_confirmation = "NeverPrompt",
	native_macos_fullscreen_mode = true,
	hide_tab_bar_if_only_one_tab = true,
	use_ime = true,

	font = wezterm.font("HackGen35 Console NF"),
	font_size = 20.0,

	inactive_pane_hsb = {
		saturation = 0.5,
		brightness = 0.5,
	},

	audible_bell = "Disabled",

	-- See: https://github.com/wez/wezterm/issues/4051
	send_composed_key_when_right_alt_is_pressed = true,

	leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 },

	keys = {
		{ key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

		{ key = "q", mods = "CTRL|SHIFT", action = act.QuickSelect },

		{ key = "n", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },
		{ key = "p", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },

		{ key = "c", mods = "CTRL|SHIFT", action = act.CloseCurrentPane({ confirm = true }) },

		{ key = "z", mods = "CTRL|SHIFT", action = act.TogglePaneZoomState },

		{ key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
		{ key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
		{ key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
		{ key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },

		{ key = "w", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
		{ key = "s", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
		{ key = "a", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Left", 10 }) },
		{ key = "d", mods = "CTRL|SHIFT", action = act.AdjustPaneSize({ "Right", 10 }) },
	},
}
