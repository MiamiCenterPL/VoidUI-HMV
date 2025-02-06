Hooks:PreHook(HUDPresenter, "_animate_present_information", "change_colors_please", function(self, present_panel, ...)
	local title_panel = present_panel:child("title")
	local text_panel = present_panel:child("text")
	if not title_panel or not text_panel then return end
	text_panel:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("presenter_text"))
	title_panel:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("presenter_title"))
end)