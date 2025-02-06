color_cyan = tweak_data.chat_colors[1]
color_blue = tweak_data.system_chat_color
color_red = tweak_data.chat_colors[3]

Hooks:PostHook(HUDManager, "add_waypoint", "custom_colors_wp", function(self, id, data, ...)
	local waypoints_available = id and self._hud and self._hud.waypoints and self._hud.waypoints[id]

	if waypoints_available then
		local wp = self._hud.waypoints[id]
		if wp and wp.bitmap and wp.distance and wp.arrow and data.distance then
			wp.bitmap:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("waypoint_icon"))
			wp.distance:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("waypoint_distance"))
			wp.arrow:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("waypoint_arrow"))
		end
	end
end)