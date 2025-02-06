Hooks:PostHook(HUDObjectives, "create_objective", "color_objectives", function(self, id , data, ...)
	local objective_panel = self._objectives[#self._objectives]
	local objective_text = objective_panel:child("objective_text")
	objective_text:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("objective_text"))
end)

	function HUDObjectives:_animate_complete_objective(objective_panel)
		local objective_border = objective_panel:child("objective_border")
		local objective_border_right = objective_panel:child("objective_border_right")
		objective_border:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("completed_objective_border"))
		objective_border_right:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("completed_objective_border"))
		local objective_text = objective_panel:child("objective_text")
		local x = objective_border:x()
		local TOTAL_T = 0.5
		local t = 0
		local get_color = VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("completed_objective_text")
		local get_color_started = VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("objective_text")
		while TOTAL_T > t do --since this mothafuka is animated we have to override the entire function bcs there's no other way for changing the color animation in this function :X
			local dt = coroutine.yield()
			t = t + dt
			objective_border:set_x(math.lerp(x, 1, t / TOTAL_T))
			objective_border:set_alpha(math.lerp(0, 1, t / TOTAL_T))
			objective_border_right:set_left(objective_border:right() - 1)
			objective_border_right:set_alpha(objective_border:alpha())
			--Convert Color(1 * (1, 1, 1)) to a table {1,1,1}
			local color_rgb = {}
			for digit in string.gmatch(string.sub(tostring(get_color), 12, -3), "([^,]+)") do
				digit = string.gsub(digit, "%s+", "")
				table.insert(color_rgb, tonumber(digit))
			end
			local starting_rgb = {}
			for digit in string.gmatch(string.sub(tostring(get_color_started), 12, -3), "([^,]+)") do
				digit = string.gsub(digit, "%s+", "")
				table.insert(starting_rgb, tonumber(digit))
			end

			local r = math.lerp(starting_rgb[1], color_rgb[1], t / TOTAL_T)
			local g = math.lerp(starting_rgb[2], color_rgb[2], t / TOTAL_T)
			local b = math.lerp(starting_rgb[3], color_rgb[3], t / TOTAL_T)
			objective_text:set_color(Color(r,g,b))
		end
		objective_border:set_x(1)
		objective_border:set_alpha(1)
		objective_border_right:set_left(objective_border:right() - 1)
		objective_border_right:set_alpha(objective_border:alpha())
		objective_text:set_color(get_color)
		objective_text:set_font_size(tweak_data.hud.active_objective_title_font_size * self._scale)
	end