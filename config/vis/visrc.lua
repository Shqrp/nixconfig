require('vis')

--- Plugins

local plug_path = (os.getenv('XDG_CONFIG_HOME') or os.getenv('HOME') .. '/.config') .. '/vis/plugins/vis-plug'
if not pcall(require, 'plugins/vis-plug') then
	os.execute('git clone --quiet https://github.com/erf/vis-plug "' .. plug_path .. '"')
end
local plug = require("plugins/vis-plug")

local plugins = {
	--- LSP
	{ 'codeberg.org/muhq/vis-lspc',        alias = "lsp" },

	--- UI
	{ 'codeberg.org/wf/vis-paw',           alias = "panel" },
	{ 'thimc/vis-colorizer',               alias = "colors",  ref = "0d67d0f809d1779c5a01fc5a58c045608238ee93" },

	--- Editing
	{ 'codeberg.org/luxanna/vis-autoclose' },
	{ 'Nomarian/vis-commentary',           alias = "comments" },
	{ 'Nomarian/vis-tab-autoconf' },

	--- Themes
	{ 'przmv/base16-vis',                  theme = true,      file = 'base16-nord' }
}
plug.init(plugins, true)

--- Language configuration

vis.ftdetect.filetypes.nix.ext = { '%.nix$' }
vis.ftdetect.filetypes.qml.ext = { '%.qml$' }
vis.ftdetect.filetypes.typst.ext = { '%.typ$' }

plug.plugins.lsp.ls_map.nix = {
	name = "nixd",
	cmd = "${pkgs.nixd}/bin/nixd",
	roots = { "flake.nix", "flake.lock" },
}
plug.plugins.lsp.ls_map.qml = {
	name = "qmlls",
	cmd = "${pkgs.kdePackages.qtdeclarative}/bin/qmlls",
}
plug.plugins.lsp.ls_map.typst = {
	name = "tinymist",
	cmd = "${pkgs.tinymist}/bin/tinymist",
}

plug.plugins.comments.comments_repl.nix = '#'
plug.plugins.comments.comments_repl.typst = '//'
plug.plugins.comments.comments_repl.qml = '//'

--- Options

vis.options.autoindent = true
vis.options.shell = "/home/shqrp/.nix-profile/bin/zsh"

plug.plugins.panel.config = {
	style_normal = "back:#2e3440,fore:#81a1c1",
	style_visual = "back:#2e3440,fore:#ebcb8b",
	style_insert = "back:#2e3440,fore:#a3be8c",
	style_replace = "back:#2e3440,fore:#b48ead",

	separator_left = " ",
	separator_right = " | ",

	modules_left = {
		'mode',
		'file'
	},
	modules_right = {
		'flags',
		'syntax',
		'percent',
		'progress'
	}
}

plug.plugins.colors.six = true

--- Keymaps

vis:map(vis.modes.INSERT, "jk", function()
	vis:feedkeys("<Escape>")
end)
vis:map(vis.modes.INSERT, "kj", function()
	vis:feedkeys("<Escape>")
end)

vis:map(vis.modes.NORMAL, " td", function()
	vis:command("lspc-typeDeclaration")
end)
vis:map(vis.modes.NORMAL, " df", function()
	vis:command("lspc-definition")
end)
vis:map(vis.modes.NORMAL, " dg", function()
	vis:command("lspc-show-diagnostics")
end)
vis:map(vis.modes.NORMAL, " dc", function()
	vis:command("lspc-declaration")
end)
vis:map(vis.modes.NORMAL, " rf", function()
	vis:command("lspc-references")
end)
vis:map(vis.modes.NORMAL, " ff", function()
	vis:command("lspc-format")
end)
vis:map(vis.modes.NORMAL, " ca", function()
	vis:command("lspc-completion")
end)

--- Events

vis.events.subscribe(vis.events.INIT, function()
	vis:command("set autoindent true")
	vis:command("set shell /home/shqrp/.nix-profile/bin/zsh")
end)

vis.events.subscribe(vis.events.WIN_OPEN, function()
	vis:command("set showeof false")
	vis:command("set tabwidth 4")
	vis:command("set relativenumbers true")
end)
