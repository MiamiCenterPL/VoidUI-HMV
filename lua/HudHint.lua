Hooks:PostHook(HUDHint, "show", "love_me_please", function(self, params)
	local clip_panel = self._hint_panel:child("clip_panel")
	local text = clip_panel:child("text")
	local text = clip_panel:child("hint_text")
	if VoidUI.options.hint_color and params.name and params.color then
		text:set_color(params.color)
	else
		text:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("hint_text_color"))
	end
end)