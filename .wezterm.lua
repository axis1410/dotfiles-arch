local wezterm = require("wezterm")
local config = wezterm.config_builder()

config = {
	enable_wayland = false,
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	font = wezterm.font("MonaSpiceNe Nerd Font Mono"),
	font_size = 18,
	max_fps = 20,
	window_decorations = "RESIZE",
	color_scheme = "Hardcore (base16)",
	native_macos_fullscreen_mode = true,
	window_padding = {
		left = 3,
		right = 3,
		top = 0,
		bottom = 0,
	},
	keys = {
		{
			key = "n",
			mods = "SHIFT|CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
	},
}
return config
