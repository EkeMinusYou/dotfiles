local wezterm = require("wezterm")
local act = wezterm.action

require("events.tab-title").setup()

return {
	color_scheme = "Catppuccin Mocha",
	tab_bar_at_bottom = true,
	window_decorations = "RESIZE | MACOS_FORCE_ENABLE_SHADOW",
	window_background_opacity = 0.9,
	macos_window_background_blur = 9,
	window_close_confirmation = "NeverPrompt",
	native_macos_fullscreen_mode = true,
	hide_tab_bar_if_only_one_tab = true,
	use_ime = false, -- for: use skkeleton in neovim

	window_padding = { left = 40, right = 0, top = 40, bottom = 0 },

	font = wezterm.font("HackGen35 Console NF"),
	font_size = 20.0,

	inactive_pane_hsb = {
		saturation = 0.5,
		brightness = 0.5,
	},

	-- TabBar
	window_frame = {
		font = wezterm.font("HackGen", { weight = "Bold" }),
		font_size = 20.0,
	},

	audible_bell = "Disabled",

	-- See: https://github.com/wez/wezterm/issues/4051
	send_composed_key_when_right_alt_is_pressed = true,

	-- See: https://github.com/mtgto/macSKK?tab=readme-ov-file#q-wezterm-%E3%81%A7-c-j-%E3%82%92%E6%8A%BC%E3%81%99%E3%81%A8%E6%94%B9%E8%A1%8C%E3%81%95%E3%82%8C%E3%81%A6%E3%81%97%E3%81%BE%E3%81%84%E3%81%BE%E3%81%99
	macos_forward_to_ime_modifier_mask = "CTRL|SHIFT",

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
