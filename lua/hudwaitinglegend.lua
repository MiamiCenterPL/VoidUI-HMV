	Hooks:PostHook(HUDWaitingLegend, "init", "init_custom_colors", function(self, hud)
		self._btn_text:set_color(VoidUI.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("waiting_color"))
	end)
