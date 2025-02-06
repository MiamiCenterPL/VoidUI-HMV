if RequiredScript == "lib/managers/playermanager" and not VoidUI_HMV then
_G.VoidUI_HMV = _G.VoidUI_HMV or {}
VoidUI_HMV.mod_path = ModPath
VoidUI_HMV.menus = VoidUI_HMV.menus or {}
VoidUI_HMV.options_path = SavePath .. "VoidUI_HMV.txt"
VoidUI_HMV.options = {}

function VoidUI_HMV:GetColor(name)
	if VoidUI_HMV.options[name] then
		local color = VoidUI_HMV.options[name]
		return Color(unpack(color))
	else
		return Color.white
	end
end

function VoidUI_HMV:DefaultConfig()
	local green = {1,0.4,1,0.6}
	local pink = {1,1,0.502,0.875}
return {
	generic_colors = false,
	change_tweakdata_colors = true,
	text_color = green,
	waypoint_arrow = green,
	waypoint_distance = green,
	waiting_color = green,
	subtitle_color = green,
	armor_value = green,
	health_value = green,
	primary_ammo = green,
	waiting_panel = green,
	secondary_ammo = green,
	casing_text = pink,
	num_pagers = pink,
	num_waves = pink,
	num_special_enemies = pink,
	ecm_time = pink,
	num_cuffed = pink,
	num_Money = pink,
	num_Jewellery = pink,
	num_Drama = pink,
	num_Ink = pink,
	num_CInk = pink,
	num_Paper = pink,
	num_CPaper = pink,
	num_BlowTorch = pink,
	num_Thermite = pink,
	num_Keycard = pink,
	num_Planks = pink,
	num_MuriaticAcid = pink,
	num_HydrogenChloride = pink,
	num_CausticSoda = pink,
	num_Crowbar = pink,
	crimenet_image_color = pink,
	num_special_kills = pink,
	num_hostages = pink,
	waypoint_icon = pink,
	num_kills = pink,
	num_civs = pink,
	num_lootbags = pink,
	num_Camera = pink,
	num_enemies = pink,
	num_gagepacks = pink,
	Timer_time = pink,
	Time_lock_time = pink,
	Unknown_time = pink,
	ChargeGun_time = pink,
	num_Inspire = pink,
	ChargeGun_name = pink,
	Timer_name = pink,
	Time_lock_name = pink,
	Unknown_name = pink,
	Breaching_time = pink,
	Breaching_name = pink,
	Barcode_scanner_time = pink,
	Barcode_scanner_name = pink,
	Helicopter_time = pink,
	Helicopter_name = pink,
	Printer_time = pink,
	Printer_name = pink,
	Paper_time = pink,
	Paper_name = pink,
	Pager_name = pink,
	Pager_time = pink,
	Boat_name = pink,
	Boat_time = pink,
	Ink_time = pink,
	Ink_name = pink,
	Achievement_time = pink,
	Achievement_name = pink,
	Water_time = pink,
	Water_name = pink,
	Water_pump_time = pink,
	Water_pump_name = pink,
	Drill_time = pink,
	Drill_name = pink,
	Thermal_drill_time = pink,
	Thermal_drill_name = pink,
	The_Beast_time = pink,
	The_Beast_name = pink,
	Hack_time = pink,
	Hack_name = pink,
	Escape_name = pink,
	Escape_time = pink,
	Fire_time = pink,
	Fire_name = pink,
	BFD_time = pink,
	EMP_time = pink,
	EMP_name = pink,
	Plane_time = pink,
	Plane_name = pink,
	BFD_name = pink,
	Saw_time = pink,
	Elf_time = pink,
	Saw_name = pink,
	Elf_name = pink,
	Cutter_time = pink,
	Cutter_name = pink,
	Fuel_time = pink,
	Fuel_name = pink,
	Tape_loop_time = pink,
	Assemble_loop_time = pink,
	Assemble_loop_name = pink,
	Tape_loop_name = pink,
	Download_time = pink,
	Download_name = pink,
	Upload_time = pink,
	Upload_name = pink,
	Analyze_time = pink,
	arrest_cooldown_time = pink,
	Power_time = pink,
	MiaCokeDestroy_time = pink,
	MiaCokeDestroy_name = pink,
	RatVanFlee_name = pink,
	RatVanFlee_time = pink,
	Bridge_time = pink,
	Bridge_name = pink,
	Power_name = pink,
	Analyze_name = pink,
	arrest_cooldown_name = pink,
	hint_text_color = green,
	level_name = pink,
	bags_count = green,
	int_time = green,
	icon_color = pink,
	primary_firemode = pink,
	primary_weapon = pink,
	secondary_firemode = pink,
	secondary_weapon = pink,
	int_bar = pink,
	bags_icon = pink,
	Pager_icon = pink,
	Boat_icon = pink,
	Drama_icon = pink,
	Fuel_icon = green,
	Escape_icon = green,
	BFD_icon = green,
	Plane_icon = green,
	Lrm_Keycard_icon = green,
	EMP_icon = green,
	Fire_icon = green,
	Money_icon = green,
	Keycard_icon = green,
	Planks_icon = green,
	MuriaticAcid_icon = green,
	HydrogenChloride_icon = green,
	CausticSoda_icon = green,
	Crowbar_icon = green,
	special_enemies_icon = green,
	Breaching_icon = green,
	Barcode_scanner_icon = green,
	Helicopter_icon = green,
	Inspire_icon = green,
	waves_icon = green,
	Printer_icon = green,
	Ink_icon = green,
	CPaper_icon = green,
	CInk_icon = green,
	Jewellery_icon = green,
	BlowTorch_icon = green,
	Thermite_icon = green,
	Paper_icon = green,
	Achievement_icon = green,
	Water_icon = green,
	Power_icon = green,
	Water_pump_icon = green,
	Cutter_icon = green,
	Camera_icon = green,
	Saw_icon = green,
	Elf_icon = green,
	Assemble_icon = green,
	Hack_icon = green,
	The_Beast_icon = green,
	Thermal_drill_icon = green,
	Drill_icon = green,
	ChargeGun_icon = green,
	Timer_icon = green,
	arrest_cooldown_icon = green,
	kills_icon = green,
	civs_icon = green,
	enemies_icon = green,
	lootbags_icon = green,
	gagepacks_icon = green,
	hostages_icon = green,
	cuffed_icon = green,
	ecm_icon = green,
	Tape_loop_icon = green,
	Upload_icon = green,
	special_kills_icon = green,
	Download_icon = green,
	Analyze_icon = green,
	heist_timer = green,
	vip_icon = green,
	pagers_icon = green,
	int_text = green,
	icon_casingbox = green,
	completed_objective_text = green,
	completed_objective_border = green,
	cable_ties_amount = green,
	bag_value = green,
	equipment_amount = green,
	pecm_amount = green,
	fore_color = green,
	grenades_amount = green,
	presenter_text = green,
	presenter_title = pink,
	objective_text = pink,
	cable_ties_icon = pink,
	equipment_icon = pink,
	grenades_icon = pink,
	bag_icon = pink,
	detection_color = {1,1,0.4,0.4},
	Gold_icon = green,
	num_Gold = pink,
	num_Lrm_Keycard = pink,
	enemy_shield_icon = pink,
	num_enemy_shield = pink,
	enemy_taser_icon = green,
	num_enemy_taser = pink,
	enemy_tank_icon = green,
	num_enemy_tank = pink,
	enemy_spooc_icon = green,
	num_enemy_spooc = pink,
	enemy_shield_icon = green,
	num_enemy_shield = pink,
	enemy_medic_icon = green,
	num_enemy_medic = pink,
	enemy_sniper_icon = green,
	num_enemy_sniper = pink,
	num_ArmorRecovery = pink,
	num_AnarchistInvulnerable = pink,
	num_GrindArmor = pink,
	GrindArmor_icon = green,
	AnarchistInvulnerable_icon = green,
	ArmorRecovery_icon = green,
	num_ArmorerInvulnerable = pink,
	num_BruteStrength = pink,
	num_StaminaMultiplier = pink,
	num_MarathonManStamina = pink,
	num_MarathonManDmgDampener = pink,
	num_LifeDrain = pink,
	num_InfMeleeStack = pink,
	num_Grinder = pink,
	num_AutoShrug = pink,
	num_MedSup = pink,
	num_GorillaRegen = pink,
	num_HostageSituationCounter = pink,
	StaminaMultiplier_icon = green,
	GorillaRegen_icon = green,
	Grinder_icon = green,
	AutoShrug_icon = green,
	MedSup_icon = green,
	MarathonManDmgDampener_icon = green,
	LifeDrain_icon = green,
	InfMeleeStack_icon = green,
	HostageSituationCounter_icon = green,
	MarathonManStamina_icon = green,
	ArmorerInvulnerable_icon = green,
	BruteStrength_icon = green,
	BloodThirst_icon = green,
	num_BloodThirst = pink,
	Berserker_icon = green,
	num_Berserker = pink,
	AcedBerserker_icon = green,
	num_AcedBerserker = pink,
	Overkill_icon = green,
	num_Overkill = pink,
	SixthSense_icon = green,
	num_SixthSense = pink,
	Bulletstorm_icon = green,
	num_Bulletstorm = pink,
	ForcedFriendship_icon = green,
	num_ForcedFriendship = pink,
	MedicCombat_icon = green,
	num_MedicCombat = pink,
	PainKillers_icon = green,
	num_PainKillers = pink,
	QuickFix_icon = green,
	num_QuickFix = pink,
	PartnersInCrime_icon = green,
	num_PartnersInCrime = pink,
	AcedPartnersInCrime_icon = green,
	num_AcedPartnersInCrime = pink,
	TotalSpeedBonus_icon = green,
	TotalSpeedBonus_icon = green,
	num_TotalSpeedBonus = pink,
	possible_loot_icon = green,
	num_possible_loot = pink,
	Barrel_icon = green,
	num_Barrel = pink,
	Receiver_icon = green,
	num_Receiver = pink,
	Stock_icon = green,
	Time_lock_icon = green,
	Unknown_icon = green,
	RatVanFlee_icon = green,
	Bridge_icon = green,
	MiaCokeDestroy_icon = green,
	num_Stock = pink
}
end

function VoidUI_HMV:Save()
	local file = io.open( self.options_path, "w+" )
	if file then
		file:write( json.encode( self.options ) )
		file:close()
	end
end

function VoidUI_HMV:Load()
	local file = io.open( self.options_path, "r" )
	if file then
		self.options_temp = json.decode( file:read("*all") )
		file:close()
		for k,v in pairs(self.options_temp) do 
			self.options[k] = v 
		end
		self.options_temp = nil
	else
		self.options = self:DefaultConfig()
		self:Save()
	end
end
elseif RequiredScript == "lib/managers/menumanager" then

Hooks:Add("LocalizationManagerPostInit", "VoidUI_HMV_Localization", function(loc)
	local loc_path = VoidUI_HMV.mod_path .. "loc/"

	if file.DirectoryExists(loc_path) then
		if BLT.Localization._current == 'cht' or BLT.Localization._current == 'zh-cn' then
			loc:load_localization_file(loc_path .. "chinese.json")
		elseif BLT.Localization._current == 'chs' then
			loc:load_localization_file(loc_path .. "schinese.json")
		else
			for _, filename in pairs(file.GetFiles(loc_path)) do
				local str = filename:match('^(.*).json$')
				if str and Idstring(str) and Idstring(str):key() == SystemInfo:language():key() then
					loc:load_localization_file(loc_path .. filename)
					break
				end
			end
		end
		loc:load_localization_file(loc_path .. "english.json", false)
	else
		log("Localization folder seems to be missing!")
	end
end)
Hooks:PreHook(VoidUIMenu, 'CreateMenu', 'support_custom_menus', function(self, params)
	if self._options_panel:child("menu_"..tostring(params.menu_id)) or self._menus[params.menu_id] then
		return self._menus[params.menu_id]
	end
end)

function VoidUIMenu:OpenColorSettingsHMV()
	self:Close()
	VoidUI_HMV.Menu = VoidUI_HMV.Menu or VoidUI_HMV_Menu:new()
	VoidUI_HMV.Menu:Open()
end
end