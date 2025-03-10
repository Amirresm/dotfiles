return {
	"rmagatti/auto-session",
	lazy = false,
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		use_git_branch = true,
		lazy_support = true,
		close_unsupported_windows = true,
		args_allow_single_directory = true,
		continue_restore_on_error = true,
		-- show_auto_restore_notif = true,
		cwd_change_handling = true,
		lsp_stop_on_restore = true,
	},
}
