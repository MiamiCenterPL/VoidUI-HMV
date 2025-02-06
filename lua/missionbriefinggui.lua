if RequiredScript == "lib/managers/menu/items/contractbrokerheistitem" then
	ContractBrokerHeistItem = ContractBrokerHeistItem or class()

elseif RequiredScript == "lib/managers/menu/missionbriefinggui" then
	function MissionBriefingGui:ready_text()
		local legend = not managers.menu:is_pc_controller() and managers.localization:get_default_macro("BTN_Y") or ""

		return legend .. managers.localization:text("menu_waiting_is_ready")
	end
end