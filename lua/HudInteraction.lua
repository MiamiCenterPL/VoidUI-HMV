if not VoidUI then return end
Hooks:PostHook(HUDInteraction, "init", "change_int_colors", function(self, hud, child_name, ...)
	local int_text = self._hud_panel:child(self._child_name_text)
	local interaction_time = self._hud_panel:child("interaction_time")
	if not int_text then return end
	int_text:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("int_text"))
	if not interaction_time then return end
	interaction_time:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("int_time"))
end)

Hooks:PostHook(HUDInteraction, "show_interaction_bar", "change_int_bar_colors", function(self, current, total, ...)
	if not self._interact_bar then return end
	 self._interact_bar:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("int_bar"))
end)

Hooks:PostHook(HUDInteraction, "set_bar_valid", "attempt_fix_deploy_bar", function(self, valid, text_id)
	if not self._interact_bar then return end
	self._interact_bar:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("int_bar"))
end)

Hooks:PostHook(HUDInteraction, "hide_interaction_bar", "change_int_bar2_colors", function(self, complete, total, ...)
	if not self._scale then return end
	local _, _, text_w, _ = self._hud_panel:child(self._child_name_text):text_rect()
	local bar = self._hud_panel:bitmap({
				layer = 5,
				w = text_w - 4,
				h = 6 * self._scale,
				color = VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("int_bar")
			})
			bar:set_position(self._hud_panel:w() / 2 - ((text_w - 4) / 2), self._hud_panel:child(self._child_name_text):y() + 66 * self._scale)
			bar:animate(callback(self, self, "_animate_interaction_complete_custom"), bar)
end)