_G.VoidUIAddon = _G.VoidUIAddon or {}
VoidUIAddon.mod_path = ModPath

color_red = VoidUI_HMV:GetColor("detection_color")
function VoidUIAddon:LoadTextures()
	for _, file in pairs(SystemFS:list(VoidUIAddon.mod_path.. "guis/textures/VoidUI")) do
		DB:create_entry(Idstring("texture"), Idstring("guis/textures/VoidUI/".. file:gsub(".texture", "")), VoidUIAddon.mod_path.. "guis/textures/VoidUI/".. file)
		Application:reload_textures({Idstring("guis/textures/VoidUI/".. file:gsub(".texture", ""))})
	end
	DB:create_entry(Idstring("texture"), Idstring("guis/textures/VoidUI_IB/hud_timer_border"), VoidUIAddon.mod_path.. "guis/textures/hud_timer_border.texture")
Application:reload_textures({Idstring("guis/textures/VoidUI_IB/hud_timer_border")})
end

	Hooks:PostHook(HUDTeammate, "set_callsign", "change_colors", function(self, id, ...)
		VoidUIAddon:LoadTextures()
		local name = self._custom_player_panel:child("name")
		local health_panel = self._custom_player_panel:child("health_panel")
		local health_background = health_panel:child("health_background")
		local health_stored_bg =  self._custom_player_panel:child("health_stored_bg")
		local delayed_damage_health_bar = health_panel:child("delayed_damage_health_bar")
		local health_bar = health_panel:child("health_bar")
		local health_value = health_panel:child("health_value")
		local downs_value = health_panel:child("downs_value")
		local detect_value = health_panel:child("detect_value")
		local armor_value = health_panel:child("armor_value")
		local weapons_panel = self._custom_player_panel:child("weapons_panel")
		local primary_ammo_panel = weapons_panel:child("primary_ammo_panel")
		local secondary_ammo_panel = weapons_panel:child("secondary_ammo_panel")
		local primary_ammo_amount = primary_ammo_panel:child("primary_ammo_amount")
		local secondary_ammo_amount = secondary_ammo_panel:child("secondary_ammo_amount")
		local primary_firemode = primary_ammo_panel:child("primary_firemode")
		local secondary_firemode = secondary_ammo_panel:child("secondary_firemode")

		local player_color = tweak_data.chat_colors[id] or Color.white
		primary_ammo_amount:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("primary_ammo"))
		secondary_ammo_amount:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("secondary_ammo"))
		primary_firemode:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("primary_firemode"))
		secondary_firemode:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("secondary_firemode"))

		health_bar:set_color(player_color * 0.8 + Color.white * 0.3)
		armor_value:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("armor_value"))
		health_value:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("health_value"))
		downs_value:set_color(downs_value)
		detect_value:set_color(color_red)
		delayed_damage_health_bar:set_color(color_red)

		local weapons_panel = self._custom_player_panel:child("weapons_panel")
		local ties_panel = weapons_panel:child("ties_panel")
		local ties_image = ties_panel:child("ties_image")
		local ties_amount = ties_panel:child("ties_count")
		ties_image:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("cable_ties_icon"))
		ties_amount:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("cable_ties_amount"))
		local grenades_panel = weapons_panel:child("grenades_panel")
		local grenades_image = grenades_panel:child("grenades_image")
		local grenades_count = grenades_panel:child("grenades_count")
		grenades_image:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("grenades_icon"))
		grenades_count:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("grenades_amount"))

		local carry_panel = self._custom_player_panel:child("carry_panel")
		local value_text = carry_panel:child("name")
		local value_text_shadow = carry_panel:child("name_shadow")
		local bag_icon = carry_panel:child("bag")
		value_text:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("bag_value"))
		bag_icon:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("bag_icon"))
	end)

	Hooks:PostHook(HUDTeammate, "set_deployable_equipment_amount", "change_deploy_color", function(self, index, data, ...)
		local weapons_panel = self._custom_player_panel:child("weapons_panel")
		local equipment_panel = weapons_panel:child("equipment_panel")
		local equipment_image = equipment_panel:child("equipment_image")
		local equipment_count = equipment_panel:child("equipment_count")
		equipment_image:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("equipment_icon"))
		equipment_count:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("equipment_amount"))
	end)

	Hooks:PostHook(HUDTeammate, "set_deployable_equipment_amount_from_string", "change_deploy_color1", function(self, index, data, ...)
		local weapons_panel = self._custom_player_panel:child("weapons_panel")
		local equipment_panel = weapons_panel:child("equipment_panel")
		local equipment_image = equipment_panel:child("equipment_image")
		local equipment_count = equipment_panel:child("equipment_count")
		equipment_image:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("equipment_icon"))
		equipment_count:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("equipment_amount"))
	end)

	Hooks:PostHook(HUDTeammate, "set_grenades_amount", "change_grenades_color2", function(self, data, ...)
		local weapons_panel = self._custom_player_panel:child("weapons_panel")
		local grenades_panel = weapons_panel:child("grenades_panel")
		local grenades_image = grenades_panel:child("grenades_image")
		local grenades_count = grenades_panel:child("grenades_count")
		local pager_count = grenades_panel:child("secondary_grenades_count")
		pager_count:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("pecm_amount"))
		grenades_image:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("grenades_icon"))
		grenades_count:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("grenades_amount"))
	end)

	Hooks:PostHook(HUDTeammate, "animate_grenade_charge", "change_grenades_color3", function(self, ...)
		local weapons_panel = self._custom_player_panel:child("weapons_panel")
		local grenades_panel = weapons_panel:child("grenades_panel")
		local grenades_image = grenades_panel:child("grenades_image")
		local grenades_count = grenades_panel:child("grenades_count")
		local pager_count = grenades_panel:child("secondary_grenades_count")
		pager_count:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("pecm_amount"))
		grenades_image:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("grenades_icon"))
		grenades_count:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("grenades_amount"))
		self._fore_color = VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("fore_color")
	end)

	Hooks:PostHook(HUDTeammate, "set_cable_ties_amount", "change_cableties_color", function(self, amount, ...)
		local weapons_panel = self._custom_player_panel:child("weapons_panel")
		local ties_panel = weapons_panel:child("ties_panel")
		local ties_image = ties_panel:child("ties_image")
		local ties_amount = ties_panel:child("ties_count")
		ties_image:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("cable_ties_icon"))
		ties_amount:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("cable_ties_amount"))
	end)

	Hooks:PostHook(HUDTeammate, "set_ammo_amount_by_type", "change_colors_ammo", function(self, type, max_clip, current_clip, current_left, max, ...)
		local weapons_panel = self._custom_player_panel:child("weapons_panel")
		local primary_ammo_panel = weapons_panel:child("primary_ammo_panel")
		local secondary_ammo_panel = weapons_panel:child("secondary_ammo_panel")
		local primary_ammo_amount = primary_ammo_panel:child("primary_ammo_amount")
		local secondary_ammo_amount = secondary_ammo_panel:child("secondary_ammo_amount")
		primary_ammo_amount:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("primary_ammo"))
		secondary_ammo_amount:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("secondary_ammo"))
	end)

	Hooks:PostHook(HUDTeammate, "set_waiting", "load_custom_txt", function(self, waiting, peer, ...)
		VoidUIAddon:LoadTextures()
	end)

	function HUDTeammate:create_custom_waiting_panel(parent_panel)
		local panel = parent_panel:panel()
		panel:set_visible(false)
		panel:set_lefttop(self._panel:lefttop())
		local name = panel:text({
			name = "name",
			font_size = 19,
			vertical = "bottom",
			layer = 1,
			font = "fonts/font_medium_mf",
			text = "Name",
			color = VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("text_color") or VoidUI_HMV:GetColor("waiting_panel")
		})
		local name_shadow = panel:text({
			name = "name_shadow",
			font_size = 19,
			vertical = "bottom",
			color = Color.black,
			font = "fonts/font_medium_mf",
			text = "Name"
		})
		local player_panel = self._custom_player_panel
		local health_panel = player_panel:child("health_panel")
		local detection = panel:panel({
			name = "detection",
			w = health_panel:w(),
			h = health_panel:h()
		})
		local health_texture = "guis/textures/VoidUI/hud_health"
		detection:set_lefttop(health_panel:lefttop())
		local armor_bar_bg = detection:bitmap({
			name = "detection_bar_bg",
			texture = health_texture,
			texture_rect = {609,0,201,472},
			layer = 2,
			color = Color.white,
			w = detection:w(),
			h = detection:h()
		})
		local detection_bar_bg = detection:bitmap({
			name = "detection_bar_bg",
			texture = health_texture,
			texture_rect = {0,0,202,472},
			color = Color.black,
			w = detection:w(),
			h = detection:h()
		})
		local detection_bar = detection:bitmap({
			name = "detection_bar",
			texture = health_texture,
			texture_rect = {203,0,202,472},
			layer = 1,
			w = detection:w(),
			h = detection:h()
		})
		local detection_shade = detection:bitmap({
			name = "detection_shade",
			texture = health_texture,
			texture_rect = {406,0,202,472},
			layer = 2,
			w = detection:w(),
			h = detection:h(),
			color = Color.black
		})
		local detection_value = panel:text({
			name = "detection_value",
			w = self._health_value,
			h = self._health_value,
			font_size = self._health_value / 1.7,
			font = "fonts/font_medium_noshadow_mf",
			layer = 3,
			text = "75%",
			vertical = "bottom",
			align = "center",
			color = color_red
		})
		detection_value:set_left(health_panel:left())
		detection_value:set_bottom(health_panel:bottom() - 3)
		name:set_leftbottom(detection:left() + 9 * self._mate_scale, detection:top())
		name_shadow:set_leftbottom(name:x() + 1, detection:top() + 1)
		local weapons_panel = player_panel:child("weapons_panel")
		local background = panel:bitmap({
			name = "background",
			texture = "guis/textures/VoidUI/hud_weapons",
			w = weapons_panel:w(),
			h = weapons_panel:h(),
			visible = true,
			layer = -1
		})
		background:set_lefttop(detection:right() - (6 * self._mate_scale), detection:top())
		local highlight_texture = "guis/textures/VoidUI/hud_highlights"
		local primary_border = panel:bitmap({
			name = "primary_border",
			texture = highlight_texture,
			texture_rect = {0,158,503,157},
			layer = 1,
			y = background:top(),
			w = self._w,
			h = self._ammo_panel_h,
			alpha = 1
		})
		primary_border:set_right(weapons_panel:right())
		local primary_weapon = panel:bitmap({
			name = "primary_weapon",
			w = weapons_panel:w() / 2 * self._mate_scale,
			h = self._ammo_panel_h / 1.2,
			texture = managers.blackmarket:get_weapon_icon_path("new_m4"),
			layer = 2,
			color = VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("primary_weapon")
		})
		primary_weapon:set_center(primary_border:center())
		local secondary_border = panel:bitmap({
			name = "secondary_border",
			texture = highlight_texture,
			texture_rect = {0,158,503,157},
			layer = 1,
			y = primary_border:bottom() + 1 * self._mate_scale,
			w = self._w,
			h = self._ammo_panel_h,
			alpha = 1
		})
		secondary_border:set_right(weapons_panel:right() - 3 * self._mate_scale)
		local secondary_weapon = panel:bitmap({
			name = "secondary_weapon",
			w = weapons_panel:w() /2 * self._mate_scale,
			h = self._ammo_panel_h / 1.2,
			texture = managers.blackmarket:get_weapon_icon_path("glock_17"),
			layer = 2,
			color = VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("secondary_weapon")
		})
		secondary_weapon:set_center(secondary_border:center())
		local deploy_panel = panel:panel({name = "deploy"})
		local throw_panel = panel:panel({name = "throw"})
		local perk_panel = panel:panel({name = "perk"})
		self:_create_equipment(deploy_panel, "frag_grenade", self._mate_scale)
		self:_create_equipment(throw_panel, "frag_grenade", self._mate_scale)
		self:_create_equipment(perk_panel, "frag_grenade", self._mate_scale)
		deploy_panel:set_leftbottom(background:left(), background:bottom())
		throw_panel:set_leftbottom(deploy_panel:right() - 1 * self._mate_scale, background:bottom())
		perk_panel:set_leftbottom(throw_panel:right() - 2 * self._mate_scale, background:bottom())
		self._wait_panel = panel
	end

	Hooks:PostHook(HUDTeammate, "add_special_equipment", "change_equipment_color", function(self, data, ...)
		local id = data.id
		local equipment_panel = self._custom_player_panel:child(id)
		if not equipment_panel then
			return
		end
		local bitmap = equipment_panel:child("bitmap")
		bitmap:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("equipment_icon"))
		local amount = equipment_panel:child("amount")
		if amount then
			amount:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("equipment_amount"))
		end
	end)

	Hooks:PostHook(HUDTeammate, "_create_equipment", "change_equipment_color2", function(self, panel, icon_name, scale, ...)
		local icon = panel:child("icon")
		icon:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("equipment_icon"))
		local amount = panel:child("amount")
		if amount then
			amount:set_color(VoidUI_HMV.options.generic_colors and VoidUI_HMV:GetColor("icon_color") or VoidUI_HMV:GetColor("equipment_amount"))
		end
	end)