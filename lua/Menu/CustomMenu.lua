VoidUI_HMV_Menu = VoidUI_HMV_Menu or class(VoidUIMenu)

VoidUI_HMV_Menu.default_menu = "colors" --The default menu to open
VoidUI_HMV_Menu.MainClass = VoidUI_HMV and VoidUI_HMV or {} --The main class

local function rgb2Hex(r,g,b)
    local rgb = (r * 0x10000) + (g * 0x100) + b
    return string.format("%x", rgb)
end

local function hex2rgb(hex)
	hex = tostring(hex)
	hex = hex:gsub("#","")
	if hex and string.len(hex) == 6 then
		return Color(tonumber("0x"..hex:sub(1,2)) / 255, tonumber("0x"..hex:sub(3,4)) / 255, tonumber("0x"..hex:sub(5,6)) / 255)
	else
		return Color(1,1,1)
	end
end

Hooks:PostHook(VoidUI_HMV_Menu, 'HighlightItem', 'hmv_check_pos_hi', function(self, item)
	if item == self._back_button then return end
	if item.panel and item.panel:bottom() > (self._panel:bottom() - 30) then
		self:move_all(-1 * (item.panel:bottom() - (self._panel:bottom() - 30) + item.panel:h()))
	elseif item.panel and item.panel:top() < self._panel:top() then
		if item.panel == self._open_menu.items[1].panel then
			self:move_all(self._panel:top() - item.panel:top() + self._open_menu.panel:child("title"):h())
		else
			self:move_all(self._panel:top() - item.panel:top())
		end
	end
end)

if not VoidUI_HMV_Menu.move_all then
	function VoidUI_HMV_Menu:move_all(value)
		for i, panel in ipairs(self._open_menu.panel:children()) do
			if panel.y then
				local starting_point = panel:y()
				local des = panel:y() + value
				panel:stop()
				panel:animate(function()
					local dur = 0.2
					local t = 0
					while dur > t do
						coroutine.yield()
						t = t + TimerManager:main():delta_time()
						panel:set_y(math.lerp(starting_point, des, t / dur))
					end
				end)
			end
		end
	end
end

Hooks:RemovePostHook("ib_add_scroll_triggers")
Hooks:PostHook(VoidUI_HMV_Menu, 'Open', 'hmv_add_scroll_triggers', function(self)
	if managers.menu:is_pc_controller() then
		Input:mouse():add_trigger(Input:mouse():button_index(Idstring("mouse wheel up")), callback(self, self, 'mouse_wheel_up'))
		Input:mouse():add_trigger(Input:mouse():button_index(Idstring("mouse wheel down")), callback(self, self, 'mouse_wheel_down'))
	end
end)

Hooks:RemovePostHook("ib_scroll_delay_up")
Hooks:PostHook(VoidUI_HMV_Menu, 'MenuUp', 'hmv_scroll_delay_up', function(self)
	self._one_scroll_up_delay = true
end)

Hooks:RemovePostHook("ib_scroll_delay_down")
Hooks:PostHook(VoidUI_HMV_Menu, 'MenuDown', 'hmv_scroll_delay_down', function(self)
	self._one_scroll_down_delay = true
end)
Hooks:Add("MenuManagerBuildCustomMenus", "MenuManagerBuildCustomMenus_VoidUI_HMV", function(menu_manager, nodes)
	local menus = file.GetFiles(VoidUI_HMV.mod_path.. "options/")
	table.insert(VoidUI.menus, VoidUI_HMV.mod_path .. "lua/Menu/options.json")
	table.insert(VoidUI_HMV.menus, VoidUI_HMV.mod_path .. "options/colors.json")
	VoidUI_HMV:Load()
	
	local custom_defaults = VoidUI_HMV:DefaultConfig()
	
	local need_save = false
	local need_save_hmv = false
	for i,val in pairs(custom_defaults) do
		if VoidUI.options[i] ~= nil then
			log("Moving option; "..tostring(i).." to HMV")
			VoidUI_HMV.options[i] = VoidUI.options[i]
			VoidUI.options[i] = nil
			need_save = true
			need_save_hmv = true
		end
		if VoidUI_HMV.options[i] == nil then
			log("Saving option; "..tostring(i))
			VoidUI_HMV.options[i]=val
			need_save_hmv = true
		end
	end
	if need_save then
		VoidUI:Save()
	end
	if need_save_hmv then
		VoidUI_HMV:Save()
	end

	tweak_data:set_custom_colors()
end)

function VoidUI_HMV_Menu:Cancel()
	if self._open_choice_dialog then
		self:CloseMultipleChoicePanel()
	elseif self._open_color_dialog then
		self:CloseColorMenu(false)
	elseif self._open_menu and self._open_menu.id == self.default_menu then
		self:Close(true)
		VoidUI.Menu = VoidUI.Menu or VoidUI_HMV_Menu:new()
		VoidUI.Menu:Open()
	elseif self._open_menu and self._open_menu.parent_menu then
		self:OpenMenu(self._open_menu.parent_menu, true)
	else
		self:Close()
	end
end



function VoidUI_HMV_Menu:mouse_wheel_down()
	if self._one_scroll_down_delay then
		self._one_scroll_down_delay = nil
		return
	end
	self:MenuDown()
end

function VoidUI_HMV_Menu:mouse_wheel_up()
	if self._one_scroll_up_delay then
		self._one_scroll_up_delay = nil
		return
	end
	self:MenuUp()
end

function VoidUI_HMV_Menu.blink(o)
	while true do
		--coroutine.yield()
		o:set_color(Color(0, 1, 1, 1))
		wait(0.3)
		o:set_color(Color.white)
		wait(0.3)
	end
end

function VoidUI_HMV_Menu:update_caret()
	local text = self._input_panel:child("input_text")
	local caret = self._input_panel:child("caret")
	local s, e = text:selection()
	local x, y, w, h = text:selection_rect()
	if s == 0 and e == 0 then
		if text:align() == "center" then
			x = text:world_x() + text:w() / 2
		else
			x = text:world_x()
		end
		y = text:world_y() + 3
	end
	h = text:h()
	if w < 2 then
		w = 2
	end
	if not self._focus then
		y = 1
		w = 0
		h = 0
	end
	caret:set_world_shape(x, y, w, h - 4)
	if caret:x() > self._input_panel:w() - 4 then 
		text:set_x(text:x() - (caret:x() - (self._input_panel:w())) - 4)
		caret:set_x(caret:x() - (caret:x() - (self._input_panel:w())) - 4)
	elseif caret:x() < 2 then 
		text:set_x(text:x() + (2 - caret:x()))
		caret:set_x(caret:x() + (2 - caret:x()))
	end
	self._open_color_dialog.color = hex2rgb(text:text())
	self._open_color_dialog.parent_item.panel:child("color"):set_color(self._open_color_dialog.color)
	local color = self._open_color_dialog.color
	for i,slider in ipairs(self._open_color_dialog.panel:children()) do
		local panel_min, panel_max = slider:world_x(), slider:world_x() + slider:w()
		if slider.child and slider:child("slider") then
			local value_bar = slider:child("slider")
			local value_text = slider:child("value")
			local value
			if slider:name() == "red_panel" then
				value = color.red
				value_bar:set_color(Color(255, value * 255, 0, 0) / 255)
			elseif slider:name() == "green_panel" then
				value = color.green
				value_bar:set_color(Color(255, 0, value * 255, 0) / 255)
			elseif slider:name() == "blue_panel" then
				value = color.blue
				value_bar:set_color(Color(255, 0, 0, value * 255) / 255)
			end
			value_bar:set_w(math.max(1,slider:w() * value))
			value_text:set_text(math.ceil(value * 255))
		end
	end

	self:set_blinking(s == e and self._focus)
end

function VoidUI_HMV_Menu:ColorPickerCallback(color, pallets, success)
	if success then
		self._open_color_dialog.parent_item.panel:child("color"):set_color(color)
		self._open_color_dialog.panel:child("hex_panel"):child("input_text"):set_text("#"..color:to_hex())
		self._open_color_dialog.color = color
		for i,slider in ipairs(self._open_color_dialog.panel:children()) do
			local panel_min, panel_max = slider:world_x(), slider:world_x() + slider:w()
			if slider.child and slider:child("slider") then
				local value_bar = slider:child("slider")
				local value_text = slider:child("value")
				local value
				if slider:name() == "red_panel" then
					value = color.red
					value_bar:set_color(Color(255, value * 255, 0, 0) / 255)
				elseif slider:name() == "green_panel" then
					value = color.green
					value_bar:set_color(Color(255, 0, value * 255, 0) / 255)
				elseif slider:name() == "blue_panel" then
					value = color.blue
					value_bar:set_color(Color(255, 0, 0, value * 255) / 255)
				end
				value_bar:set_w(math.max(1,slider:w() * value))
				value_text:set_text(math.ceil(value * 255))
			end
		end
	end
end

function VoidUI_HMV_Menu:set_blinking(b)
	local caret = self._input_panel:child("caret")

	if b == self._blinking then
		return
	end

	if b then
		caret:animate(self.blink)
	else
		caret:stop()
	end

	self._blinking = b

	if not self._blinking then
		caret:set_color(Color.white)
	end
end

function VoidUI_HMV_Menu:SetColorSlider(item, x, type, add)
	local panel_min, panel_max = item:world_x(), item:world_x() + item:w() 
	x = math.clamp(x, panel_min, panel_max)
	local value_bar = item:child("slider")
	local value_text = item:child("value")
	local percentage = (math.clamp(value_text:text() + (add or 0), 0, 255) - 0) / 255
	if not add then
		percentage = (x - panel_min) / (panel_max - panel_min)
	end
	local value = string.format("%.0f", 0 + (255 - 0) * percentage)
	value_bar:set_w(math.max(1,item:w() * percentage))
	value_bar:set_color(Color(255, type == 1 and value or 0, type == 2 and value or 0, type == 3 and value or 0) / 255)
	value_text:set_text(value)
	local color = self._open_color_dialog.color
	self._open_color_dialog.color = Color(type == 1 and value / 255 or color.red, type == 2 and value / 255 or color.green, type == 3 and value / 255 or color.blue)
	self._open_color_dialog.parent_item.panel:child("color"):set_color(self._open_color_dialog.color)
	self._open_color_dialog.panel:child("hex_panel"):child("input_text"):set_text("#"..rgb2Hex(type == 1 and value or color.red * 255, type == 2 and value or color.green * 255, type == 3 and value or color.blue * 255))
end

function VoidUI_HMV_Menu:key_release(o, k)
	if self._key_pressed == k then
		self._key_pressed = false
	end
end

function VoidUI_HMV_Menu:update_key_down(o, k)
	wait(0.6)

	local text = self._input_panel:child("input_text")

	while self._key_pressed == k do
		local s, e = text:selection()
		local n = utf8.len(text:text())
		local d = math.abs(e - s)

		if self._key_pressed == Idstring("backspace") then
			if s == e and s > 0 then
				text:set_selection(s - 1, e)
			end

			text:replace_text("")
		elseif self._key_pressed == Idstring("delete") then
			if s == e and s < n then
				text:set_selection(s, e + 1)
			end

			text:replace_text("")
		elseif ctrl() and self._key_pressed == Idstring("v") or self._key_pressed == Idstring("insert") then
			local clipboard = Application:get_clipboard() or ""

			text:set_text(clipboard:gsub("_",""))
		elseif self._key_pressed == Idstring("left") then
			if s < e then
				text:set_selection(s, s)
			elseif s > 0 then
				text:set_selection(s - 1, s - 1)
			end
		elseif self._key_pressed == Idstring("right") then
			if s < e then
				text:set_selection(e, e)
			elseif s < n then
				text:set_selection(s + 1, s + 1)
			end
		else
			self._key_pressed = false
		end

		self:update_caret()
		wait(0.03)
	end
end

function VoidUI_HMV_Menu:enter_text(o, s)

	--[[if self._skip_first then
		self._skip_first = false

		return
	end]]

	local text = self._input_panel:child("input_text")

	text:replace_text(s)

	local lbs = text:line_breaks()

	if #lbs > 1 then
		local s = lbs[2]
		local e = utf8.len(text:text())

		text:set_selection(s, e)
		text:replace_text("")
	end
	self:update_caret()
end

function VoidUI_HMV_Menu:key_press(o, k)
	if not self._focus then return end
	self._input_panel:enter_text(callback(self, self, "enter_text"))

	local text = self._input_panel:child("input_text")
	local s, e = text:selection()
	local n = utf8.len(text:text())
	local d = math.abs(e - s)
	self._key_pressed = k
	text:stop()
	text:animate(callback(self, self, "update_key_down"), k)
	if k == Idstring("backspace") then
		if s == e and s > 0 then
			text:set_selection(s - 1, e)
		end
		text:replace_text("")
	elseif k == Idstring("delete") then
		if s == e and s < n then
			text:set_selection(s, e + 1)
		end
		text:replace_text("")
	elseif ctrl() and k == Idstring("v") or k == Idstring("insert") then
		local clipboard = Application:get_clipboard() or ""

		text:set_text(clipboard:gsub("_",""))
	elseif k == Idstring("left") then
		if s < e then
			text:set_selection(s, s)
		elseif s > 0 then
			text:set_selection(s - 1, s - 1)
		end
	elseif k == Idstring("right") then
		if s < e then
			text:set_selection(e, e)
		elseif s < n then
			text:set_selection(s + 1, s + 1)
		end
	elseif self._key_pressed == Idstring("end") then
		text:set_selection(n, n)
	elseif self._key_pressed == Idstring("home") then
		text:set_selection(0, 0)
	elseif k == Idstring("enter") then
		if type(self._enter_callback) ~= "number" then
			--self._enter_callback()
		end
	elseif k == Idstring("esc") --[[and type(self._esc_callback) ~= "number"]] then
		text:set_text("#000000")
		text:set_selection(0, 0)
		--self._esc_callback()
	end
	self:update_caret()
end

function VoidUI_HMV_Menu:OpenColorMenu(item)
	local dialog = item.panel:parent():panel({
		name = "color_panel_"..tostring(item.id),
		x = item.panel:x(),
		y = item.panel:bottom(),
		w = item.panel:w(),
		h = ColorPicker and 191 or 156,
		layer = 20,
		alpha = 0
	})
	if dialog:bottom() > item.panel:parent():h() then
		dialog:set_bottom(item.panel:top())
	end
	local border = dialog:bitmap({
		name = "border",
		alpha = 0.3,
		layer = 1,
		h = 0
	})
	dialog:bitmap({
		name = "blur_bg",
		texture = "guis/textures/test_blur_df",
		render_template = "VertexColorTexturedBlur3D",
		y = 3,
		w = dialog:w(),
		h = dialog:h(),
		layer = 0,
	})
	local bg = dialog:bitmap({
		name = "bg",
		alpha = 0.7,
		color = Color.black,
		layer = 2,
		x = 2,
		y = 2,
		w = dialog:w() - 4,
		h = 0,
	})	
	local color = item.value
	local red_panel = dialog:panel({
		name = "red_panel",
		x = 5,
		y = 5,
		w = dialog:w() - 10,
		h = 25,
		layer = 3
	})
	local red_slider = red_panel:bitmap({
		name = "slider",
		alpha = 0.3,
		layer = 2,
		w = math.max(1, red_panel:w() * (color.red / 1)),
		color = Color(color.red,0,0)
	})
	red_panel:bitmap({
		name = "bg",
		alpha = 0.1,
	})	
	red_panel:text({
		name = "title",
		font_size = 18,
		font = tweak_data.menu.pd2_small_font,
		text = managers.localization:to_upper_text("VoidUI_red"),
		x = 85,
		w = red_panel:w() - 90,
		h = 25,
		align = "right",
		vertical = "center",
		layer = 3
	})
	red_panel:text({
		name = "value",
		font_size = 18,
		font = tweak_data.menu.pd2_small_font,
		text = string.format("%.0f", color.red * 255),
		x = 5,
		w = 80,
		h = 25,
		vertical = "center",
		layer = 3
	})
	local green_panel = dialog:panel({
		name = "green_panel",
		x = 5,
		y = 32,
		w = dialog:w() - 10,
		h = 25,
		layer = 3
	})
	local green_slider = green_panel:bitmap({
		name = "slider",
		alpha = 0.3,
		layer = 2,
		w =  math.max(1, green_panel:w() * (color.green / 1)),
		color = Color(0,color.green,0)
	})	
	green_panel:bitmap({
		name = "bg",
		alpha = 0,
	})
	green_panel:text({
		name = "title",
		font_size = 18,
		font = tweak_data.menu.pd2_small_font,
		text = managers.localization:to_upper_text("VoidUI_green"),
		x = 85,
		w = red_panel:w() - 90,
		h = 25,
		align = "right",
		vertical = "center",
		layer = 3
	})
	green_panel:text({
		name = "value",
		font_size = 18,
		font = tweak_data.menu.pd2_small_font,
		text = string.format("%.0f", color.green * 255),
		x = 5,
		w = 80,
		h = 25,
		vertical = "center",
		layer = 3
	})
	local blue_panel = dialog:panel({
		name = "blue_panel",
		x = 5,
		y = 59,
		w = dialog:w() - 10,
		h = 25,
		layer = 3
	})
	local blue_slider = blue_panel:bitmap({
		name = "slider",
		alpha = 0.3,
		layer = 2,
		w = math.max(1, blue_panel:w() * (color.blue / 1)),
		color = Color(0,0,color.blue)
	})	
	blue_panel:bitmap({
		name = "bg",
		alpha = 0,
	})
	blue_panel:text({
		name = "title",
		font_size = 18,
		font = tweak_data.menu.pd2_small_font,
		text = managers.localization:to_upper_text("VoidUI_blue"),
		x = 85,
		w = red_panel:w() - 90,
		h = 25,
		align = "right",
		vertical = "center",
		layer = 3
	})
	blue_panel:text({
		name = "value",
		font_size = 18,
		font = tweak_data.menu.pd2_small_font,
		text = string.format("%.0f", color.blue * 255),
		x = 5,
		w = 80,
		h = 25,
		vertical = "center",
		layer = 3
	})

	local hex_panel = dialog:panel({
		name = "hex_panel",
		x = 5,
		y = 85,
		w = dialog:w() - 10,
		h = 25,
		layer = 3
	})
	hex_panel:bitmap({
		name = "bg",
		alpha = 0,
	})
	hex_panel:text({
		name = "title",
		font_size = 18,
		font = tweak_data.menu.pd2_small_font,
		text = managers.localization:to_upper_text("VoidUI_HMV_Hex"),
		x = 85,
		w = blue_panel:w() - 90,
		h = 25,
		align = "right",
		vertical = "center",
		layer = 3
	})
	hex_panel:text({
		name = "input_text",
		font_size = 18,
		font = tweak_data.menu.pd2_small_font,
		text = "#"..rgb2Hex(
			string.format("%.0f", color.red * 255),
			string.format("%.0f", color.green * 255),
			string.format("%.0f", color.blue * 255)
		),
		x = 5,
		w = 80,
		h = 25,
		vertical = "center",
		layer = 3
	})
	local color_picker_panel
	if ColorPicker then

		local colorpicker_data = {
			color = color,
			done_callback = callback(self,self,"ColorPickerCallback"),
			palettes = {
			"66ff99",
			"66ffff",
			"ff6666",
			"ffcc66",
			"33ccff",
			"ff80df",
			"fcba03"
			}
		}


		self._colorpicker = ColorPicker:new("VoidUIHMVCP",colorpicker_data)
		color_picker_panel = dialog:panel({
			name = "color_picker_panel",
			x = 5,
			y = 120,
			w = dialog:w() - 10,
			h = 25,
			layer = 3
		})
		color_picker_panel:bitmap({
			name = "bg",
			alpha = 0,
		})
		color_picker_panel:text({
			name = "color_picker",
			font_size = 18,
			font = tweak_data.menu.pd2_small_font,
			text = managers.localization:to_upper_text("VoidUI_HMV_color_picker"),
			x = 85,
			w = color_picker_panel:w() - 90,
			h = 25,
			align = "right",
			vertical = "center",
			layer = 3
		})
	end

	local accept_panel = dialog:panel({
		name = "accept_panel",
		x = 5,
		y = ColorPicker and 155 or 120,
		w = dialog:w() - 10,
		h = 25,
		layer = 3
	})
	accept_panel:bitmap({
		name = "bg",
		alpha = 0,
	})
	accept_panel:text({
		name = "title",
		font_size = 18,
		font = tweak_data.menu.pd2_small_font,
		text = managers.localization:text("dialog_new_tradable_item_accept"),
		x = 5,
		w = red_panel:w() - 10,
		h = 25,
		align = "right",
		vertical = "center",
		layer = 3,
	})
	self._open_color_dialog = { parent_item = item, panel = dialog, color = item.value, selected = 1,  items = {red_panel, green_panel, blue_panel, accept_panel, hex_panel, color_picker_panel} }
	
	dialog:animate(function(o)	
		local h = o:h()
		do_animation(0.1, function (p)
			o:set_alpha(math.lerp(0, 1, p))
			border:set_h(math.lerp(0, h, p))
			bg:set_h(border:h() - 4)
		end)
		o:set_alpha(1)
		border:set_h(h)
		bg:set_h(border:h() - 4)
	end)
end

function VoidUI_HMV_Menu:mouse_press(o, button, x, y)
	x, y = managers.mouse_pointer:convert_fullscreen_16_9_mouse_pos(x, y)
	if button == Idstring("0") then	
		if self._open_choice_dialog then
			if self._open_choice_dialog.panel:inside(x,y) then
				for i, item in pairs(self._open_choice_dialog.items) do
					if alive(item) and item:inside(x,y) and item:alpha() == 1 then
						local parent_item = self._open_choice_dialog.parent_item
						parent_item.panel:child("title_selected"):set_text(self._open_choice_dialog.items[i]:text())
						self.MainClass.options[parent_item.id] = i
						parent_item.value = i
						self:CloseMultipleChoicePanel()
						self:CreateChangeWarning()
					end
				end
			else
				self:CloseMultipleChoicePanel()
			end
		elseif self._open_color_dialog and alive(self._open_color_dialog.panel) then
			if self._open_color_dialog.panel:inside(x,y) then
				if self._focus then
					self._focus = false
					self:update_caret()
				end
				for i, item in pairs(self._open_color_dialog.items) do
					if alive(item) and item:inside(x,y) then
						if item:child("slider") then
							self._slider = {slider = item, type = i}
							self:SetColorSlider(item, x, i)
							managers.mouse_pointer:set_pointer_image("grab")
						elseif item:child("input_text") then
							self._input_panel = item
							self._focus = true
							local caret = self._input_panel:rect({
								name = "caret",
								layer = 2,
								x = 0,
								y = 0,
								w = 0,
								h = 0,
								color = Color(0.05, 1, 1, 1)
							})
							self._input_panel:key_press(callback(self, self, "key_press"))
							self._input_panel:key_release(callback(self, self, "key_release"))
							local last_letter = string.len(self._input_panel:child("input_text"):text())
							self._input_panel:child("input_text"):set_selection(last_letter, last_letter)
							self:update_caret()
						elseif item:child("color_picker") then
							self._colorpicker:Show()
						elseif item:name("accept_panel") then
							self:Confirm()
						else
							self:CloseColorMenu(true)
						end
					end
				end
			else
				self:CloseColorMenu(false)
			end
		elseif self._highlighted_item and self._highlighted_item.panel:inside(x,y) then
			self:ActivateItem(self._highlighted_item, x)
		end

	elseif button == Idstring("1") then
	
	end
end

--
function VoidUI_HMV_Menu:open_support_page()
	os.execute("cmd /c start https://ko-fi.com/miamicenter")
end

local skill_names = {"Inspire", "BloodThirst", "Berserker", "AcedBerserker", "Overkill", "SixthSense", "Bulletstorm", "ForcedFriendship", "MedicCombat", "PainKillers", "QuickFix", "PartnersInCrime", "AcedPartnersInCrime", "TotalSpeedBonus"}
local timer_names = {
	"Drill", "Hack", "Timer", "Saw", "Cutter", "Fuel", "Tape_loop", "Upload", "Download", "Analyze", "Breaching", "Barcode_scanner",
	"Helicopter", "Printer", "Paper", "Ink", "ChargeGun", "Achievement", "Time_lock", "Crane", "The_Beast", "Thermal_drill", "Water",
	"Water_pump", "Elf", "Power", "Bridge", "MiaCokeDestroy", "RatVanFlee", "BFD", "Escape", "Fire", "Assemble", "EMP", "Plane", "Pager", "Boat"
	}
local trackers_names = {"Drama"}
local counters_names = {"kills", "special_kills", "enemies", "special_enemies", "civs", "lootbags", "possible_loot", "gagepacks", "Camera"}
local special_enemy_counters_names = {"enemy_spooc", "enemy_shield", "enemy_medic", "enemy_sniper", "enemy_tank", "enemy_taser"}
local collectables_names = {"Jewellery", "Money", "Keycard", "Planks", "MuriaticAcid", "HydrogenChloride", "CausticSoda", "Crowbar", "BlowTorch", "Thermite", "Gold", "CInk", "CPaper", "Barrel", "Receiver", "Stock", "Lrm_Keycard"}
local perkdecks_names = {"ArmorRecovery", "StaminaMultiplier", "ArmorerInvulnerable", "AutoShrug", "Grinder", "MedSup"}
local crewchief_cards = {"BruteStrength", "MarathonManStamina", "MarathonManDmgDampener", "HostageSituationCounter"}
local infiltrator_cards = {"LifeDrain", "InfMeleeStack"}
local anarchist_cards = {"AnarchistInvulnerable", "GrindArmor"}
local categories = {"Counters", "Collectables", "Timers", "Trackers", "Skills", "Perks", {name = "SpecialEnemyCounters", parent_menu = "Counters"}, {name = "CrewChief", parent_menu = "Perks"}, {name = "Infiltrator", parent_menu = "Perks"},
{name = "Anarchist", parent_menu = "Perks"}}
function VoidUI_HMV_Menu:CreateInfoboxCategories(item)
	for i, category in pairs(categories) do
		if type(category) == "string" then
			self:CreateMenu({
				menu_id = category,
				parent_menu = "color_infobox",
				title = managers.localization:text("VoidUI_HMV_"..category.."_title")
			})
		elseif type(category) == "table" then
			self:CreateMenu({
				menu_id = category.name,
				parent_menu = category.parent_menu,
				title = managers.localization:text("VoidUI_HMV_"..category.name.."_title")
			})
		end
	end
	if not self._menus["color_infobox"] then
		self:CreateMenu({
			menu_id = "color_infobox",
			parent_menu = "colors",
			title = managers.localization:text("VoidUI_HMV_InfoboxAddon_title")
		})
	
		for i, category in pairs(categories) do
			if type(category) == "string" then
				self:CreateButton({
					menu_id = "color_infobox",
					id = category,
					title = managers.localization:text("VoidUI_HMV_"..category.."_title"),
					description = managers.localization:text("VoidUI_HMV_"..category.."_desc"),
					callback = category.."_callback",
					enabled = true
				})
			elseif type(category) == "table" then
				self:CreateButton({
					menu_id = category.parent_menu,
					id = category.name,
					title = managers.localization:text("VoidUI_HMV_"..category.name.."_title"),
					description = managers.localization:text("VoidUI_HMV_"..category.name.."_desc"),
					callback = category.name.."_callback",
					enabled = true
				})
			end
		end
	end
	self:OpenMenu("color_infobox")
end

function VoidUI_HMV_Menu:build_category_menu(item, table, menu)
	local menu_panel = self._options_panel:child("menu_"..tostring(menu))
	if not menu_panel then return end

	for i, name in pairs(table) do
		if menu_panel:child("button_"..name) then
			break
		end
		self:CreateButton({
			menu_id = menu,
			id = name,
			title = managers.localization:text("VoidUI_HMV_"..name.."_title"),
			description = managers.localization:text("VoidUI_HMV_color_settings_desc"),
			callback = "create_infobox_color_menu",
			enabled = true
		})
	end
end

function VoidUI_HMV_Menu:Timers_callback(item)
	self:OpenMenu("Timers")
	self:build_category_menu(item, timer_names, "Timers")
end

function VoidUI_HMV_Menu:Trackers_callback(item)
	self:OpenMenu("Trackers")
	self:build_category_menu(item, timer_names, "Timers")
end

function VoidUI_HMV_Menu:Counters_callback(item)
	self:OpenMenu("Counters")
	self:build_category_menu(item, counters_names, "Counters")
end

function VoidUI_HMV_Menu:SpecialEnemyCounters_callback(item)
	self:OpenMenu("SpecialEnemyCounters")
	self:build_category_menu(item, special_enemy_counters_names, "SpecialEnemyCounters")
end
function VoidUI_HMV_Menu:CrewChief_callback(item)
	self:OpenMenu("CrewChief")
	self:build_category_menu(item, crewchief_cards, "CrewChief")
end
function VoidUI_HMV_Menu:Infiltrator_callback(item)
	self:OpenMenu("Infiltrator")
	self:build_category_menu(item, infiltrator_cards, "Infiltrator")
end
function VoidUI_HMV_Menu:Anarchist_callback(item)
	self:OpenMenu("Anarchist")
	self:build_category_menu(item, anarchist_cards, "Anarchist")
end

function VoidUI_HMV_Menu:Collectables_callback(item)
	self:OpenMenu("Collectables")
	self:build_category_menu(item, collectables_names, "Collectables")
end

function VoidUI_HMV_Menu:Skills_callback(item)
	self:OpenMenu("Skills")
	self:build_category_menu(item, skill_names, "Skills")
end
function VoidUI_HMV_Menu:Perks_callback(item)
	self:OpenMenu("Perks")
	self:build_category_menu(item, perkdecks_names, "Perks")
end

function VoidUI_HMV_Menu:create_infobox_color_menu(item)
	if not item or not item.id then
		return
	end
	local id = item.id
	if self._menus["infobox_color_settings"] then
		if self._options_panel:child("menu_"..tostring("infobox_color_settings")) then
			self._options_panel:remove(self._options_panel:child("menu_"..tostring("infobox_color_settings")))
		end
		self._menus["infobox_color_settings"] = nil
	end

	if self._menus["timer_color_settings"] then
		if self._options_panel:child("menu_"..tostring("timer_color_settings")) then
			self._options_panel:remove(self._options_panel:child("menu_"..tostring("timer_color_settings")))
		end
		self._menus["timer_color_settings"] = nil
	end

	if table.contains(timer_names, id) then
		local menu = self:CreateMenu({
			menu_id = "timer_color_settings",
			parent_menu = self._open_menu.id,
			title = managers.localization:text("VoidUI_HMV_"..id.."_title")
		})
		self:CreateColorSelect({
			menu_id = "timer_color_settings",
			id = id.."_icon",
			title = managers.localization:text("VoidUI_HMV_icon_title"),
			description = managers.localization:text("VoidUI_HMV_icon_desc"),
			value = VoidUI_HMV.options[id.."_icon"] and Color(unpack(VoidUI_HMV.options[id.."_icon"])) or Color(1,0.502,0.875),
			default_value = {0.4,1,0.6},
			enabled = true
		})
		self:CreateColorSelect({
			menu_id = "timer_color_settings",
			id = id.."_time",
			title = managers.localization:text("VoidUI_HMV_time_title"),
			description = managers.localization:text("VoidUI_HMV_time_desc"),
			value = VoidUI_HMV.options[id.."_time"] and Color(unpack(VoidUI_HMV.options[id.."_time"])) or Color(1,0.502,0.875),
			default_value = {1,0.502,0.875},
			enabled = true
		})
		self:CreateColorSelect({
			menu_id = "timer_color_settings",
			id = id.."_name",
			title = managers.localization:text("VoidUI_HMV_name_title"),
			description = managers.localization:text("VoidUI_HMV_name_desc"),
			value = VoidUI_HMV.options[id.."_name"] and Color(unpack(VoidUI_HMV.options[id.."_name"])) or Color(1,0.502,0.875),
			default_value = {1,0.502,0.875},
			enabled = true
		})
		self:OpenMenu("timer_color_settings")
	else
		local menu = self:CreateMenu({
			menu_id = "infobox_color_settings",
			parent_menu = self._open_menu.id,
			title = managers.localization:text("VoidUI_HMV_"..id.."_title")
		})
		self:CreateColorSelect({
			menu_id = "infobox_color_settings",
			id = id.."_icon",
			title = managers.localization:text("VoidUI_HMV_icon_title"),
			description = managers.localization:text("VoidUI_HMV_icon_desc"),
			value = Color(unpack(VoidUI_HMV.options[id.."_icon"] and VoidUI_HMV.options[id.."_icon"] or {0.4,1,0.6})),
			default_value = {0.4,1,0.6},
			enabled = true
		})

		self:CreateColorSelect({
			menu_id = "infobox_color_settings",
			id = "num_"..id,
			title = managers.localization:text("VoidUI_HMV_num_title"),
			description = managers.localization:text("VoidUI_HMV_num_desc"),
			value = Color(unpack(VoidUI_HMV.options["num_"..id] and VoidUI_HMV.options["num_"..id] or {1,0.502,0.875})),
			default_value = {1,0.502,0.875},
			enabled = true
		})
		self:OpenMenu("infobox_color_settings")
	end
end