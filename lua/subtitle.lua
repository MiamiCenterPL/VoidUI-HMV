if RequiredScript == "core/lib/managers/subtitle/coresubtitlepresenter" and VoidUI.options.enable_subtitles then
	local color
	core:module("CoreSubtitlePresenter")
	local show_text_original = OverlayPresenter.show_text
	function OverlayPresenter:show_text(...)
		show_text_original(self, ...)
		VoidUI_HMV = _G.VoidUI_HMV
		if not color and VoidUI_HMV then
			color = VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("subtitle_color")
		end
		local label = self.__subtitle_panel:child("label")
		if label and color then
			label:set_color(color)
		end
	end
	Hooks:PostHook(OverlayPresenter, "show_text", "change_subtitle_color", function(self, text, duration)
		local label = self.__subtitle_panel:child("label")
		VoidUI_HMV = _G.VoidUI_HMV
		if not color and VoidUI_HMV then
			color = VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("subtitle_color")
		end
		if label and color then
			label:set_color(color)
		end
	end)
end

--This is soo stupid but it works.
--no questions asked, no complains, okay?
--OKAY!?