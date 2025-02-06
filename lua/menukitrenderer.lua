function MenuKitRenderer:_set_player_slot(nr, params)
	local peer = managers.network:session():peer(nr)
	local ready = peer:waiting_for_player_ready()
	params.status = --[[string.upper(]]managers.localization:text(ready and "menu_waiting_is_ready" or "menu_waiting_is_not_ready")
	params.kit_panel_visible = true

	MenuKitRenderer.super._set_player_slot(self, nr, params)
end