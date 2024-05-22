-- See: https://github.com/KevinSilvester/wezterm-config/blob/4f4661a1671119882a8c173d814f8b73314cd556/events/tab-title.lua

local wezterm = require("wezterm")

-- Inspired by https://github.com/wez/wezterm/discussions/628#discussioncomment-1874614

local nf = wezterm.nerdfonts

local GLYPH_SEMI_CIRCLE_LEFT = nf.ple_left_half_circle_thick --[[ '' ]]
local GLYPH_SEMI_CIRCLE_RIGHT = nf.ple_right_half_circle_thick --[[ '' ]]

local M = {}

local __cells__ = {} -- wezterm FormatItems (ref: https://wezfurlong.org/wezterm/config/lua/wezterm/format.html)

local colors = {
	default = { bg = "#45475a", fg = "#1c1b19" },
	is_active = { bg = "#7FB4CA", fg = "#11111b" },
	hover = { bg = "#587d8c", fg = "#1c1b19" },
}

local _set_process_name = function(s)
	local a = string.gsub(s, "(.*[/\\])(.*)", "%2")
	return a:gsub("%.exe$", "")
end

local _set_title = function(process_name, base_title, max_width, inset)
	local title
	inset = inset or 0

	if process_name:len() > 0 then
		title = process_name .. " ~ " .. base_title
	else
		title = base_title
	end

	if title:len() > max_width - inset then
		local diff = title:len() - max_width + inset
		title = wezterm.truncate_right(title, title:len() - diff)
	end

	return title
end

---@param fg string
---@param bg string
---@param attribute table
---@param text string
local _push = function(bg, fg, attribute, text)
	table.insert(__cells__, { Background = { Color = bg } })
	table.insert(__cells__, { Foreground = { Color = fg } })
	table.insert(__cells__, { Attribute = attribute })
	table.insert(__cells__, { Text = text })
end

M.setup = function()
	---@diagnostic disable-next-line: unused-local
	wezterm.on("format-tab-title", function(tab, _tabs, _panes, _config, hover, max_width)
		__cells__ = {}

		local bg
		local fg
		local process_name = _set_process_name(tab.active_pane.foreground_process_name)
		local title = _set_title(process_name, tab.active_pane.title, max_width)

		if tab.is_active then
			bg = colors.is_active.bg
			fg = colors.is_active.fg
		elseif hover then
			bg = colors.hover.bg
			fg = colors.hover.fg
		else
			bg = colors.default.bg
			fg = colors.default.fg
		end

		-- Left semi-circle
		_push("rgba(0, 0, 0, 0.4)", bg, { Intensity = "Bold" }, GLYPH_SEMI_CIRCLE_LEFT)

		-- Title
		_push(bg, fg, { Intensity = "Bold" }, " " .. title)

		-- Right padding
		_push(bg, fg, { Intensity = "Bold" }, " ")

		-- Right semi-circle
		_push("rgba(0, 0, 0, 0.4)", bg, { Intensity = "Bold" }, GLYPH_SEMI_CIRCLE_RIGHT)

		return __cells__
	end)
end

return M
