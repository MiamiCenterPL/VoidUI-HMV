local text_color
local icon_color

if not VoidUI.options.enable_assault then return end
--VoidUI_HMV.options.generic_colors
Hooks:PostHook(HUDAssaultCorner, 'init', 'recolor_casing', function(self, ...)
    if not self._custom_hud_panel then return end
    VoidUI_HMV:Load()
    text_color = VoidUI_HMV:GetColor("text_color")
    icon_color = VoidUI_HMV:GetColor("icon_color")
    local casing_panel = self._custom_hud_panel:child("casing_panel")
    casing_panel:child("icon_casingbox"):set_color(VoidUI_HMV.options.generic_colors and icon_color or VoidUI_HMV:GetColor("icon_casingbox"))
    
    local buffs_panel = self._custom_hud_panel:child("buffs_panel")
    buffs_panel:child("vip_icon"):set_color(VoidUI_HMV.options.generic_colors and icon_color or VoidUI_HMV:GetColor("vip_icon"))
end)
Hooks:PostHook(HUDAssaultCorner, 'show_casing', 'recolor_casing_text', function(self, ...)
    local casing_panel = self._custom_hud_panel:child("casing_panel")
    local casingbox_panel = casing_panel:child("casingbox_panel")
    local text_panel = casing_panel:child("text_panel")
    if not casingbox_panel or not casingbox_panel:child("text_panel") then return end
    casingbox_panel:child("text_panel"):stop()
    local casingbox_text_color = VoidUI_HMV.options.generic_colors and text_color or VoidUI_HMV:GetColor("casing_text")
    casingbox_panel:child("text_panel"):animate(callback(self, self, "_animate_text"), text_panel:script().text_list, casingbox_text_color)
    
end)

Hooks:PostHook(HUDAssaultCorner, 'setup_icons_panel', 'recolor_infoboxes', function(self, icons_panel, ...)
    local icons_panel = self._custom_hud_panel:child("icons_panel")
    text_color = VoidUI_HMV:GetColor("text_color")
    icon_color = VoidUI_HMV:GetColor("icon_color")
    icons_panel:child("pagers_panel"):child("pagers_icon"):set_color(VoidUI_HMV.options.generic_colors and icon_color or VoidUI_HMV:GetColor("pagers_icon"))
    icons_panel:child("pagers_panel"):child("ecm_icon"):set_color(VoidUI_HMV.options.generic_colors and icon_color or VoidUI_HMV:GetColor("ecm_icon"))
    icons_panel:child("pagers_panel"):child("ecm_time"):set_color(VoidUI_HMV.options.generic_colors and text_color or VoidUI_HMV:GetColor("ecm_time"))
    icons_panel:child("pagers_panel"):child("num_pagers"):set_color(VoidUI_HMV.options.generic_colors and text_color or VoidUI_HMV:GetColor("num_pagers"))
    icons_panel:child("cuffed_panel"):child("num_cuffed"):set_color(VoidUI_HMV.options.generic_colors and text_color or VoidUI_HMV:GetColor("num_cuffed"))
    icons_panel:child("cuffed_panel"):child("cuffed_icon"):set_color(VoidUI_HMV.options.generic_colors and icon_color or VoidUI_HMV:GetColor("cuffed_icon"))
    icons_panel:child("hostages_panel"):child("num_hostages"):set_color(VoidUI_HMV.options.generic_colors and text_color or VoidUI_HMV:GetColor("num_hostages"))
    icons_panel:child("hostages_panel"):child("hostages_icon"):set_color(VoidUI_HMV.options.generic_colors and icon_color or VoidUI_HMV:GetColor("hostages_icon"))
    if icons_panel:child("wave_panel") then
        icons_panel:child("wave_panel"):child("waves_icon"):set_color(VoidUI_HMV.options.generic_colors and icon_color or VoidUI_HMV:GetColor("waves_icon"))
        icons_panel:child("wave_panel"):child("num_waves"):set_color(VoidUI_HMV.options.generic_colors and text_color or VoidUI_HMV:GetColor("num_waves"))
    end
end)

Hooks:PostHook(HUDAssaultCorner, 'set_assault_wave_number', 'recolor_infoboxes2', function(self, assault_number)
    local icons_panel = self._custom_hud_panel:child("icons_panel")
    if icons_panel:child("wave_panel") then
        icons_panel:child("wave_panel"):child("waves_icon"):set_color(VoidUI_HMV.options.generic_colors and icon_color or VoidUI_HMV:GetColor("waves_icon"))
        icons_panel:child("wave_panel"):child("num_waves"):set_color(VoidUI_HMV.options.generic_colors and text_color or VoidUI_HMV:GetColor("num_waves"))
    end
end)