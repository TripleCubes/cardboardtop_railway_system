-- title:   Box Town
-- author:  TripleCubes
-- license: MIT License
-- script:  lua

-- The Moonscript compiled to Lua code pass the 200 local variable limit of Lua, so I end up
-- needing to write the rest of the code in the generated lua file, where I can manually delete
-- the 823871897213 local keywords Moonscript generated

WINDOW_W = 240
WINDOW_H = 136
UP = 0
DOWN = 1
LEFT = 2
RIGHT = 3
ENTITY_RAIL = 0
ENTITY_STATION = 1
ENTITY_TRAIN = 2
ENTITY_RESTAURANT = 3
ENTITY_REFILL = 4
ENTITY_FARM = 5
BUILDING_ENTITY_LIST = {
  ENTITY_RAIL,
  ENTITY_STATION,
  ENTITY_RESTAURANT,
  ENTITY_REFILL,
  ENTITY_FARM
}
rail_grid = { }
RAIL_HORIZONTAL = 0
RAIL_VERTICAL = 1
RAIL_UP_LEFT = 2
RAIL_UP_RIGHT = 3
RAIL_DOWN_LEFT = 4
RAIL_DOWN_RIGHT = 5
RAIL_3_UP = 6
RAIL_3_DOWN = 7
RAIL_3_LEFT = 8
RAIL_3_RIGHT = 9
RAIL_4 = 10
AT_START = 0
AT_GAME = 1
using_kb = true
btn_keyboard = { }
btn_controller = { }
at = AT_START
t = 0
map_sz = {
  x = 0,
  y = 0
}
entity_list = { }
draw_list = { }
camera = {
  pos = { }
}
local cursor = {
  pos = { }
}
cursor_move_hold_0 = 0
cursor_move_hold_1 = 0
cursor_move_hold_2 = 0
cursor_move_hold_3 = 0
exit_menu_holding_5 = false
exit_menu_holding_4 = false
money_count = 6
CURSOR_MOVE_HOLD_TIME = 30
DPAD_CAMERA = 0
DPAD_CURSOR = 1
dpad_mode = DPAD_CURSOR
UI_MENU = 0
UI_BTN = 1
_ = UI_PROGRESS_BAR
ui_list = { }
menu_build = { }
menu_kb_controller = { }
menu_opening = nil
btn_selected = nil
btn_switched = false
BUILDING_RAIL = 0
BUILDING_RESTAURANT = 1
BUILDING_STATION = 2
BUILDING_REFILL = 3
BUILDING_FARM = 4
RAIL_COST = 1
RESTAURANT_COST = 12
STATION_COST = 20
REFILL_COST = 3
FARM_COST = 12
rail_inventory = 0
station_inventory = 0
refill_inventory = 0
farm_inventory = 0
building_btn_list = { }
building_btn_pos_list = { }
building_btn_selected = nil
TAB_BTN_MARGIN_LEFT = 4
TAB_BTN_MARGIN_TOP = 4
TAB_BTN_SPACING_H = 12
TAB_BTN_SZ = {
  x = 32,
  y = 8
}
local CARD_BTN_MARGIN_LEFT = TAB_BTN_MARGIN_LEFT + TAB_BTN_SZ.x + 4
local CARD_BTN_MARGIN_TOP = TAB_BTN_MARGIN_TOP
local CARD_BTN_SPACING_SZ = {
  x = 20,
  y = 20 + 7
}
local CARD_BTN_SZ = {
  x = 16,
  y = 16
}
local STATS_POS = {
  x = 2,
  y = 2
}
local DRAW_SPR = 0
local DRAW_RECT = 1
local DRAW_TEXT = 2
local entity_new
entity_new = function(type_tag, pos, sz, update_func, draw_func)
  local e = {
    type_tag = type_tag,
    pos = veccopy(pos),
    sz = veccopy(sz),
    update = update_func,
    draw = draw_func
  }
  table.insert(entity_list, e)
  return e
end
local entity_list_update
entity_list_update = function()
  for i = #entity_list, 1, -1 do
    local v = entity_list[i]
    v.update(i, v)
  end
end
local entity_list_draw
entity_list_draw = function()
  for i, v in ipairs(entity_list) do
    v.draw(v)
  end
end
local draw
draw = function(spr_id, x, y, color_key, scale, flip, rotate, w, h, center_pos, z_index)
  local d = {
    type_tag = DRAW_SPR,
    spr_id = spr_id,
    x = x,
    y = y,
    color_key = color_key,
    scale = scale,
    flip = flip,
    rotate = rotate,
    w = w,
    h = h,
    center_pos = veccopy(center_pos),
    z_index = z_index
  }
  return table.insert(draw_list, d)
end
local draw_rect
draw_rect = function(x, y, w, h, color, center_pos, z_index)
  local d = {
    type_tag = DRAW_RECT,
    x = x,
    y = y,
    w = w,
    h = h,
    color = color,
    center_pos = veccopy(center_pos),
    z_index = z_index
  }
  return table.insert(draw_list, d)
end
local draw_text
draw_text = function(text, x, y, color, fixed, scale, small_font, center_pos, z_index)
  local d = {
    type_tag = DRAW_TEXT,
    text = text,
    x = x,
    y = y,
    color = color,
    fixed = fixed,
    scale = scale,
    small_font = small_font,
    center_pos = center_pos,
    z_index = z_index
  }
  return table.insert(draw_list, d)
end
local draw_list_draw
draw_list_draw = function()
  table.sort(draw_list, function(a, b)
    if a.z_index ~= b.z_index then
      return a.z_index < b.z_index
    end
    return a.center_pos.y < b.center_pos.y
  end)
  for i, v in ipairs(draw_list) do
    if v.type_tag == DRAW_SPR then
      spr(v.spr_id, v.x, v.y, v.color_key, v.scale, v.flip, v.rotate, v.w, v.h)
    end
    if v.type_tag == DRAW_RECT then
      rect(v.x, v.y, v.w, v.h, v.color)
    end
    if v.type_tag == DRAW_TEXT then
      print(v.text, v.x, v.y, v.color, v.fixed, v.scale, v.small_font)
    end
  end
  draw_list = { }
end
local vecequals
vecequals = function(veca, vecb)
  return veca.x == vecb.x and veca.y == vecb.y
end
local vecnew
vecnew = function(x, y)
  return {
    x = x,
    y = y
  }
end
local veccopy
veccopy = function(vec)
  return {
    x = vec.x,
    y = vec.y
  }
end
local vecadd
vecadd = function(vec_a, vec_b)
  return {
    x = vec_a.x + vec_b.x,
    y = vec_a.y + vec_b.y
  }
end
local vecsub
vecsub = function(vec_a, vec_b)
  return {
    x = vec_a.x - vec_b.x,
    y = vec_a.y - vec_b.y
  }
end
local vecmul
vecmul = function(vec, n)
  return {
    x = vec.x * n,
    y = vec.y * n
  }
end
local vecdiv
vecdiv = function(vec, n)
  return {
    x = vec.x / n,
    y = vec.y / n
  }
end
local vecdivdiv
vecdivdiv = function(vec, n)
  return {
    x = vec.x // n,
    y = vec.y // n
  }
end
local vecmod
vecmod = function(vec, n)
  return {
    x = vec.x % n,
    y = vec.y % n
  }
end
local veclength
veclength = function(vec)
  return math.sqrt(vec.x * vec.x + vec.y * vec.y)
end
local veclengthsqr
veclengthsqr = function(vec)
  return vec.x * vec.x + vec.y * vec.y
end
local vecparam
vecparam = function(vec)
  return vec.x, vec.y
end
local rect_collide
rect_collide = function(pos_a, sz_a, pos_b, sz_b)
  if pos_a.x + sz_a.x <= pos_b.x then
    return false
  end
  if pos_a.y + sz_a.y <= pos_b.y then
    return false
  end
  if pos_a.x >= pos_b.x + sz_b.x then
    return false
  end
  if pos_a.y >= pos_b.y + sz_b.y then
    return false
  end
  return true
end
local in_rect
in_rect = function(pos, rect_pos, rect_sz)
  if pos.x < rect_pos.x then
    return false
  end
  if pos.y < rect_pos.y then
    return false
  end
  if pos.x >= rect_pos.x + rect_sz.x then
    return false
  end
  if pos.y >= rect_pos.y + rect_sz.y then
    return false
  end
  return true
end
local rndf
rndf = function(a, b)
  return math.random() * (b - a) + a
end
local rndi
rndi = function(a, b)
  return math.random(a, b)
end
local dice
dice = function(a, b)
  local rnd = rndi(1, b)
  return rnd >= 1 and rnd <= a
end
local list_shuffle
list_shuffle = function(list)
  local result = { }
  local list_sz = #list
  for i = 1, list_sz do
    local rnd = rndi(1, list_sz - i + 1)
    table.insert(result, list[rnd])
    table.remove(list, rnd)
  end
  return result
end
local is_in_list
is_in_list = function(list, item)
  for i, v in ipairs(list) do
    if v == item then
      return true
    end
  end
  return false
end
local find_in_list
find_in_list = function(list, item)
  for i, v in ipairs(list) do
    if v == item then
      return i
    end
  end
  return -1
end
local bkg_draw
bkg_draw = function()
  return box_draw()
end
local box_draw
box_draw = function()
  local draw_pos = get_draw_pos(vecnew(8, 8))
  rect(draw_pos.x, draw_pos.y, map_sz.x * 8, map_sz.y * 8, 4)
  local tape_w = 16
  local tape_h = 16
  rect(draw_pos.x + (map_sz.x * 8 - tape_w) / 2, draw_pos.y, tape_w, map_sz.y * 8, 3)
  rect(draw_pos.x, draw_pos.y + (map_sz.y * 8 - tape_h) / 2, map_sz.x * 8, tape_h, 3)
  return rect(draw_pos.x, draw_pos.y + map_sz.y * 8, map_sz.x * 8, 20 * 8, 2)
end
local game_init
game_init = function()
  ui_list = { }
  entity_list = { }
  cursor.pos = vecnew(8, 8)
  create_menu_build()
  for y = 1, map_sz.y do
    table.insert(rail_grid, { })
    for x = 1, map_sz.x do
      table.insert(rail_grid[y], -1)
    end
  end
end
local start_init
start_init = function()
  ui_list = { }
  return create_start_screen_menus()
end
BOOT = function()
  map_sz = vecnew(16, 10)
  camera.pos = vecnew((-WINDOW_W + map_sz.x * 8) / 2 + 8, (-WINDOW_H + map_sz.y * 8) / 2 + 8)
  return start_init()
end
local game
game = function()
  game_controls_update()
  ui_list_update()
  entity_list_update()
  cls(13)
  bkg_draw()
  entity_list_draw()
  draw_list_draw()
  game_controls_draw()
  game_ui_draw()
  ui_list_draw()
  if not btn(5) then
    exit_menu_holding_5 = false
  end
  if not btn(4) then
    exit_menu_holding_4 = false
  end
  btn_switched = false
end
local start
start = function()
  ui_list_update()
  cls(13)
  box_draw()
  title_draw()
  ui_list_draw()
  btn_switched = false
end
TIC = function()
  if at == AT_GAME then
    game()
  elseif at == AT_START then
    start()
  end
  t = t + 1
end
title_draw = function()
	if menu_opening ~= nil then
		return
	end
  print('Cardboardtop Railway', 4, 4, 12, false, 2, true)
  return print('System', 4, 17, 12, false, 2, true)
end
create_start_screen_menus = function()
  	local btn_play = btn_new(vecnew(4, 32), vecnew(60, 8), -1, vecnew(0, 0), 'Play', function() end)
  	local btn_kb_controller = btn_new(vecnew(4, 44), vecnew(60, 8), -1, vecnew(0, 0), 'Kb/Controller', function()
    	return open_menu(menu_kb_controller)
  	end)
  	btn_connect(btn_play, btn_kb_controller, DOWN)
  	select_btn(btn_play)


  	menu_kb_controller = menu_new(nil, vecnew(0, 0))
  	btn_keyboard = btn_new(vecnew(4, 14), vecnew(48, 8), -1, vecnew(0, 0), 'Keyboard', function()
    	btn_keyboard.highlight = true
    	btn_controller.highlight = false
    	using_kb = true
  	end)
  	btn_controller = btn_new(vecnew(4, 26), vecnew(48, 8), -1, vecnew(0, 0), 'Controller', function()
    	btn_keyboard.highlight = false
    	btn_controller.highlight = true
    	using_kb = false
  	end)

	btn_connect(btn_keyboard, btn_controller, DOWN)

  	menu_add_ui(menu_kb_controller, btn_keyboard)
  	menu_add_ui(menu_kb_controller, btn_controller)
end

create_nav = function(menu)
  local y = TAB_BTN_MARGIN_TOP
  local btn_back = btn_new(vecnew(TAB_BTN_MARGIN_LEFT, y), TAB_BTN_SZ, 16, vecnew(1, 1), 'Back', function(btn)
    close_all_menus()
    exit_menu_holding_4 = true
  end)
  y = y + TAB_BTN_SPACING_H
  local btn_build = btn_new(vecnew(TAB_BTN_MARGIN_LEFT, y), TAB_BTN_SZ, 17, vecnew(1, 1), 'Build', function(btn)
    return trace('btn 2 pressed')
  end)
  y = y + TAB_BTN_SPACING_H
  local btn_game = btn_new(vecnew(TAB_BTN_MARGIN_LEFT, y), TAB_BTN_SZ, 18, vecnew(1, 1), 'Game', function(btn)
    return trace('btn 2 pressed')
  end)
  local nav_btn_list = {
    btn_back,
    btn_build,
    btn_game
  }
  btn_connect(btn_back, btn_build, DOWN)
  btn_connect(btn_build, btn_game, DOWN)
  menu_add_ui(menu, btn_back)
  menu_add_ui(menu, btn_build)
  menu_add_ui(menu, btn_game)
  return nav_btn_list
end
connect_to_nav = function(nav_btn_list, btn)
  for i, v in ipairs(nav_btn_list) do
    v.right = btn
  end
  btn.left = nav_btn_list[1]
end
create_menu_build = function()
  menu_build = menu_new(nil, vecnew(0, WINDOW_H - 60))
  local menu = menu_build
  local x = CARD_BTN_MARGIN_LEFT
  local y = CARD_BTN_MARGIN_TOP
  local btn_rail = create_building_btn(x, y, 32, BUILDING_RAIL)
  select_building_btn(btn_rail)
  x = x + CARD_BTN_SPACING_SZ.x
  local btn_restaurant = create_building_btn(x, y, 34, BUILDING_RESTAURANT)
  x = x + CARD_BTN_SPACING_SZ.x
  local btn_station = create_building_btn(x, y, 36, BUILDING_STATION)
  x = x + CARD_BTN_SPACING_SZ.x
  local btn_refill = create_building_btn(x, y, 38, BUILDING_REFILL)
  x = CARD_BTN_MARGIN_LEFT
  y = y + CARD_BTN_SPACING_SZ.y
  local btn_farm = create_building_btn(x, y, 40, BUILDING_FARM)
  building_btn_list = {
    btn_rail,
    btn_restaurant,
    btn_station,
    btn_refill,
    btn_farm
  }
  building_btn_connect(4, 2)
  menu_add_ui(menu, btn_rail)
  menu_add_ui(menu, btn_restaurant)
  menu_add_ui(menu, btn_station)
  menu_add_ui(menu, btn_refill)
  menu_add_ui(menu, btn_farm)
  local nav_btn_list = create_nav(menu)
  nav_btn_list[2].highlight = true
  connect_to_nav(nav_btn_list, btn_farm)
  return connect_to_nav(nav_btn_list, btn_rail)
end
create_building_btn = function(x, y, spr_id, building_type_tag)
  local btn = btn_new(vecnew(x, y), CARD_BTN_SZ, spr_id, vecnew(2, 2), '', function(btn)
    return select_building_btn(btn)
  end)
  btn.building_type_tag = building_type_tag
  table.insert(building_btn_pos_list, {
    pos = vecnew(x, y),
    building_type_tag = building_type_tag
  })
  return btn
end
building_btn_connect = function(grid_w, grid_h)
  for x = 1, grid_w do
    for y = 1, grid_h do
      building_btn_connect_around(grid_w, grid_h, x, y)
    end
  end
end
building_btn_connect_around = function(grid_w, grid_h, x, y)
  local btn = get_building_btn_from_xy(grid_w, grid_h, x, y)
  if btn == nil then
    return 
  end
  if x - 1 >= 1 then
    btn.left = get_building_btn_from_xy(grid_w, grid_h, x - 1, y)
  end
  if x + 1 <= grid_w then
    btn.right = get_building_btn_from_xy(grid_w, grid_h, x + 1, y)
  end
  if y - 1 >= 1 then
    btn.up = get_building_btn_from_xy(grid_w, grid_h, x, y - 1)
  end
  if y + 1 <= grid_h then
    btn.down = get_building_btn_from_xy(grid_w, grid_h, x, y + 1)
  end
end
get_building_btn_from_xy = function(grid_w, grid_h, x, y)
  local i = (y - 1) * grid_w + (x - 1)
  local btn = nil
  if i + 1 <= #building_btn_list then
    btn = building_btn_list[i + 1]
  end
  return btn
end
game_controls_update = function()
  dpad_mode_controls()
  menu_controls()
  return cursor_controls()
end
dpad_mode_controls = function()
  if menu_opening ~= nil then
    return 
  end
  if btnp(6) then
    if dpad_mode == DPAD_CAMERA then
      dpad_mode = DPAD_CURSOR
    else
      dpad_mode = DPAD_CAMERA
    end
  end
  if dpad_mode == DPAD_CAMERA then
    return dpad_camera_update()
  else
    return dpad_cursor_update()
  end
end
menu_controls = function()
  if btnp(7) then
    if menu_opening == nil then
      return open_menu(menu_build)
    else
      return close_all_menus()
    end
  end
end
cursor_controls = function()
  if menu_opening ~= nil then
    return 
  end
  if dpad_mode ~= DPAD_CURSOR then
    return 
  end
  local pos = vecdivdiv(cursor.pos, 8)
  local cursor_sz = get_cursor_sz()
  if not exit_menu_holding_4 then
    if building_btn_selected.building_type_tag == BUILDING_RAIL then
      if btn(4) then
        rail_new(cursor.pos)
      end
    end
    if building_btn_selected.building_type_tag == BUILDING_STATION then
      if btn(4) then
        station_new(cursor.pos)
      end
    end
    if building_btn_selected.building_type_tag == BUILDING_RESTAURANT then
      if btnp(4) then
        restaurant_new(cursor.pos)
      end
    end
    if building_btn_selected.building_type_tag == BUILDING_REFILL then
      if btnp(4) then
        refill_new(cursor.pos)
      end
    end
    if building_btn_selected.building_type_tag == BUILDING_FARM then
      if btnp(4) then
        farm_new(cursor.pos)
      end
    end
  end
  if btn(5) and not exit_menu_holding_5 then
    if cursor_sz.x == 16 then
      for x = 0, 1 do
        for y = 0, 1 do
          local pos2 = vecadd(pos, vecnew(x, y))
          building_rm(pos2)
        end
      end
    else
      return building_rm(pos)
    end
  end
end
building_rm = function(pos)
  rail_rm_xy(pos)
  station_rm_xy(pos)
  restaurant_rm_xy(pos)
  refill_rm_xy(pos)
  return farm_rm_xy(pos)
end
dpad_camera_update = function()
  if btn(0) then
    camera.pos.y = camera.pos.y - 1
  end
  if btn(1) then
    camera.pos.y = camera.pos.y + 1
  end
  if btn(2) then
    camera.pos.x = camera.pos.x - 1
  end
  if btn(3) then
    camera.pos.x = camera.pos.x + 1
  end
end
dpad_cursor_update = function()
  local move = vecnew(0, 0)
  if btnp(0) then
    move.y = move.y - 8
  end
  if btn(0) then
    cursor_move_hold_0 = cursor_move_hold_0 + 1
    if cursor_move_hold_0 >= CURSOR_MOVE_HOLD_TIME and t % 4 == 0 then
      move.y = move.y - 8
    end
  else
    cursor_move_hold_0 = 0
  end
  if btnp(1) then
    move.y = move.y + 8
  end
  if btn(1) then
    cursor_move_hold_1 = cursor_move_hold_1 + 1
    if cursor_move_hold_1 >= CURSOR_MOVE_HOLD_TIME and t % 4 == 0 then
      move.y = move.y + 8
    end
  else
    cursor_move_hold_1 = 0
  end
  if btnp(2) then
    move.x = move.x - 8
  end
  if btn(2) then
    cursor_move_hold_2 = cursor_move_hold_2 + 1
    if cursor_move_hold_2 >= CURSOR_MOVE_HOLD_TIME and t % 4 == 0 then
      move.x = move.x - 8
    end
  else
    cursor_move_hold_2 = 0
  end
  if btnp(3) then
    move.x = move.x + 8
  end
  if btn(3) then
    cursor_move_hold_3 = cursor_move_hold_3 + 1
    if cursor_move_hold_3 >= CURSOR_MOVE_HOLD_TIME and t % 4 == 0 then
      move.x = move.x + 8
    end
  else
    cursor_move_hold_3 = 0
  end
  local next_pos = vecadd(cursor.pos, move)
  local cursor_sz = get_cursor_sz()
  if next_pos.x < 8 or next_pos.x - 8 + cursor_sz.x > map_sz.x * 8 then
    move.x = 0
  end
  if next_pos.y < 8 or next_pos.y - 8 + cursor_sz.y > map_sz.y * 8 then
    move.y = 0
  end
  cursor.pos = vecadd(cursor.pos, move)
end
game_controls_draw = function()
  return cursor_draw()
end
game_ui_draw = function()
  spr(65, STATS_POS.x + 2, STATS_POS.y + 2, 0, 1, 0, 0, 1, 1)
  print(money_count, STATS_POS.x + 8, STATS_POS.y + 1, 12, false, 1, true)
  return bottom_left_card_draw()
end
bottom_left_card_draw = function()
  if building_btn_selected == nil then
    return 
  end
  if dpad_mode == DPAD_CAMERA then
    return 
  end
  local building_draw_pos = vecnew(2, WINDOW_H - CARD_BTN_SZ.y - 2)
  local building_spr_id = 0
  local building_cost = 0
  local building_inventory = 0
  if building_btn_selected.building_type_tag == BUILDING_RAIL then
    building_spr_id = 32
    building_cost = RAIL_COST
    building_inventory = rail_inventory
  end
  if building_btn_selected.building_type_tag == BUILDING_RESTAURANT then
    building_spr_id = 34
    building_cost = RESTAURANT_COST
    building_inventory = -1
  end
  if building_btn_selected.building_type_tag == BUILDING_STATION then
    building_spr_id = 36
    building_cost = STATION_COST
    building_inventory = station_inventory
  end
  if building_btn_selected.building_type_tag == BUILDING_REFILL then
    building_spr_id = 38
    building_cost = REFILL_COST
    building_inventory = refill_inventory
  end
  if building_btn_selected.building_type_tag == BUILDING_FARM then
    building_spr_id = 40
    building_cost = FARM_COST
    building_inventory = farm_inventory
  end
  rect(building_draw_pos.x, building_draw_pos.y, CARD_BTN_SZ.x, CARD_BTN_SZ.y, 12)
  spr(building_spr_id, building_draw_pos.x, building_draw_pos.y, 0, 1, 0, 0, 2, 2)
  if building_inventory == -1 then
    local cost_str = 'cost: ' .. building_cost
    return print(cost_str, building_draw_pos.x + CARD_BTN_SZ.x + 2, building_draw_pos.y + 10, 12, false, 1, true)
  else
    local cost_str = 'cost: ' .. building_cost
    print(cost_str, building_draw_pos.x + CARD_BTN_SZ.x + 2, building_draw_pos.y + 3, 12, false, 1, true)
    local iv_str = 'inventory: ' .. building_inventory
    return print(iv_str, building_draw_pos.x + CARD_BTN_SZ.x + 2, building_draw_pos.y + 10, 12, false, 1, true)
  end
end
cursor_draw = function()
  if dpad_mode ~= DPAD_CURSOR then
    return 
  end
  local cursor_sz = get_cursor_sz()
  local draw_pos = get_draw_pos(cursor.pos)
  local top_left = vecnew(draw_pos.x, draw_pos.y)
  local top_right = vecnew(draw_pos.x + cursor_sz.x - 1, draw_pos.y)
  local bottom_right = vecnew(draw_pos.x + cursor_sz.x - 1, draw_pos.y + cursor_sz.y - 1)
  local bottom_left = vecnew(draw_pos.x, draw_pos.y + cursor_sz.y - 1)
  line(top_left.x, top_left.y, top_right.x, top_right.y, 12)
  line(top_right.x, top_right.y, bottom_right.x, bottom_right.y, 12)
  line(bottom_right.x, bottom_right.y, bottom_left.x, bottom_left.y, 12)
  return line(bottom_left.x, bottom_left.y, top_left.x, top_left.y, 12)
end
get_cursor_sz = function()
  if building_btn_selected.building_type_tag == BUILDING_RESTAURANT then
    return vecnew(16, 16)
  end
  if building_btn_selected.building_type_tag == BUILDING_FARM then
    return vecnew(16, 16)
  end
  return vecnew(8, 8)
end
get_draw_pos = function(vec)
  return vecsub(vec, camera.pos)
end
ui_new = function(type_tag, update_func, draw_func)
  local ui = {
    type_tag = type_tag,
    update = update_func,
    draw = draw_func
  }
  table.insert(ui_list, ui)
  return ui
end
ui_list_update = function()
  for i = #ui_list, 1, -1 do
    local v = ui_list[i]
    v.update(i, v)
  end
end
ui_list_draw = function()
  for i, v in ipairs(ui_list) do
    v.draw(v)
  end
end
open_menu = function(menu)
  menu_opening = menu
  btn_selected = menu.first_btn
end
close_all_menus = function()
  menu_opening = nil
  btn_selected = nil
end
menu_new = function(up_menu, pos)
  local menu = ui_new(UI_MENU, menu_update, menu_draw)
  menu.up_menu = up_menu
  menu.sub_ui_list = { }
  menu.pos = veccopy(pos)
  menu.first_btn = nil
  return menu
end
menu_update = function(i, menu)
  if menu_opening ~= menu then
    return 
  end
  if btnp(5) then
    if menu.up_menu == nil then
      exit_menu_holding_5 = true
      return close_all_menus()
    else
      return open_menu(menu.up_menu)
    end
  end
end
menu_draw = function(menu)
  if menu_opening ~= menu then
    return 
  end
  if menu == menu_build then
    rect(menu.pos.x, menu.pos.y, WINDOW_W, WINDOW_H, 14)
    draw_desc(vecnew(menu.pos.x + 128, menu.pos.y + 4))
    return draw_building_costs()
  end
	if menu == menu_kb_controller then
		print('Are you using keyboard or controller?', 4, 4, 12, false, 1, true)
	end
end
draw_desc = function(pos)
  if btn_selected.building_type_tag == nil then
    return 
  end
  if btn_selected.building_type_tag == BUILDING_RAIL then
    print('RAIL', pos.x, pos.y, 12, false, 1, true)
    print('Rail', pos.x, pos.y + 9, 12, false, 1, true)
  end
  if btn_selected.building_type_tag == BUILDING_RESTAURANT then
    print('RESTAURANT', pos.x, pos.y, 12, false, 1, true)
    print('When a train go near a', pos.x, pos.y + 9, 12, false, 1, true)
    print('restaurant, money is', pos.x, pos.y + 9 + 7, 12, false, 1, true)
    print('collected', pos.x, pos.y + 9 + 7 * 2, 12, false, 1, true)
    print('Refill using Refill', pos.x, pos.y + 9 + 7 * 3 + 2, 12, false, 1, true)
    print('Removed restaurant wont go', pos.x, pos.y + 9 + 7 * 4 + 2 * 2, 12, false, 1, true)
    print('back to inventory', pos.x, pos.y + 9 + 7 * 5 + 2 * 2, 12, false, 1, true)
  end
  if btn_selected.building_type_tag == BUILDING_STATION then
    print('STATION', pos.x, pos.y, 12, false, 1, true)
    print('Train go in and out of stations', pos.x, pos.y + 9, 12, false, 1, true)
    print('Can only be placed at left and', pos.x, pos.y + 11 + 7, 12, false, 1, true)
    print('right border of the map', pos.x, pos.y + 11 + 7 * 2, 12, false, 1, true)
  end
  if btn_selected.building_type_tag == BUILDING_REFILL then
    print('REFILL', pos.x, pos.y, 12, false, 1, true)
    print('Place next to restaurant to', pos.x, pos.y + 9, 12, false, 1, true)
    print('refill it', pos.x, pos.y + 9 + 7, 12, false, 1, true)
  end
  if btn_selected.building_type_tag == BUILDING_FARM then
    print('FARM', pos.x, pos.y, 12, false, 1, true)
    print('Create Refills', pos.x, pos.y + 9, 12, false, 1, true)
    return print('Refills are placed nearby', pos.x, pos.y + 11 + 7, 12, false, 1, true)
  end
end
draw_building_costs = function()
  for i, v in ipairs(building_btn_pos_list) do
    if v.building_type_tag == BUILDING_RAIL then
      draw_building_cost_under_btn(vecadd(v.pos, menu_build.pos), RAIL_COST, rail_inventory)
    end
    if v.building_type_tag == BUILDING_RESTAURANT then
      draw_building_cost_under_btn(vecadd(v.pos, menu_build.pos), RESTAURANT_COST, -1)
    end
    if v.building_type_tag == BUILDING_STATION then
      draw_building_cost_under_btn(vecadd(v.pos, menu_build.pos), STATION_COST, station_inventory)
    end
    if v.building_type_tag == BUILDING_REFILL then
      draw_building_cost_under_btn(vecadd(v.pos, menu_build.pos), REFILL_COST, refill_inventory)
    end
    if v.building_type_tag == BUILDING_FARM then
      draw_building_cost_under_btn(vecadd(v.pos, menu_build.pos), FARM_COST, farm_inventory)
    end
  end
end
draw_building_cost_under_btn = function(pos, cost, inventory)
  print(cost, pos.x, pos.y + CARD_BTN_SZ.y + 2, 12, false, 1, true)
  if inventory ~= -1 then
    return print(inventory, pos.x + 9, pos.y + CARD_BTN_SZ.y + 2, 4, false, 1, true)
  end
end
menu_add_ui = function(menu, ui)
  if menu.first_btn == nil and ui.type_tag == UI_BTN then
    menu.first_btn = ui
  end
  ui.menu = menu
  return table.insert(menu.sub_ui_list, ui)
end
select_btn = function(btn)
  btn_selected = btn
end
select_building_btn = function(btn)
  for i, v in ipairs(building_btn_list) do
    v.highlight = false
  end
  btn.highlight = true
  building_btn_selected = btn
  local cursor_sz = get_cursor_sz()
  if cursor.pos.x - 8 + cursor_sz.x > map_sz.x * 8 then
    cursor.pos.x = cursor.pos.x - 8
  end
  if cursor.pos.y - 8 + cursor_sz.y > map_sz.y * 8 then
    cursor.pos.y = cursor.pos.y - 8
  end
end
btn_new = function(pos, sz, spr_id, spr_sz, txt, clicked_func)
  local btn = ui_new(UI_BTN, btn_update, btn_draw)
  btn.pos = veccopy(pos)
  btn.sz = veccopy(sz)
  btn.spr_id = spr_id
  btn.spr_sz = veccopy(spr_sz)
  btn.txt = txt
  btn.clicked_func = clicked_func
  btn.up = nil
  btn.down = nil
  btn.left = nil
  btn.right = nil
  btn.menu = nil
  btn.highlight = false
  return btn
end
btn_update = function(i, btn)
  if btn_selected ~= btn then
    return 
  end
  if btnp(4) then
    btn.clicked_func(btn)
  end
  if btn_switched then
    return 
  end
  if btnp(0) and btn.up ~= nil then
    btn_switched = true
    select_btn(btn.up)
  end
  if btnp(1) and btn.down ~= nil then
    btn_switched = true
    select_btn(btn.down)
  end
  if btnp(2) and btn.left ~= nil then
    btn_switched = true
    select_btn(btn.left)
  end
  if btnp(3) and btn.right ~= nil then
    btn_switched = true
    return select_btn(btn.right)
  end
end
btn_draw = function(btn)
  if menu_opening ~= btn.menu then
    return 
  end
  local draw_pos = veccopy(btn.pos)
  if btn.menu ~= nil then
    draw_pos = vecadd(draw_pos, btn.menu.pos)
  end
  local txt_pos = vecnew(0, 0)
  if btn.spr_id == -1 then
    txt_pos = vecadd(draw_pos, vecnew(1, 1))
  else
    txt_pos = vecadd(draw_pos, vecnew(8, 1))
  end
  local bkg_color = 12
  local shading_color = 14
  if btn.highlight then
    bkg_color = 4
    shading_color = 3
  end
  rect(draw_pos.x, draw_pos.y, btn.sz.x, btn.sz.y, bkg_color)
  line(draw_pos.x, draw_pos.y + btn.sz.y, draw_pos.x + btn.sz.x - 1, draw_pos.y + btn.sz.y, shading_color)
  print(btn.txt, txt_pos.x, txt_pos.y, 14, false, 1, true)
  if btn.spr_id ~= -1 then
    spr(btn.spr_id, draw_pos.x, draw_pos.y, 0, 1, 0, 0, btn.spr_sz.x, btn.spr_sz.y)
  end
  local top_left = vecnew(draw_pos.x - 1, draw_pos.y - 1)
  local top_right = vecnew(draw_pos.x + btn.sz.x, draw_pos.y - 1)
  local bottom_right = vecnew(draw_pos.x + btn.sz.x, draw_pos.y + btn.sz.y)
  local bottom_left = vecnew(draw_pos.x - 1, draw_pos.y + btn.sz.y)
  if btn_selected == btn then
    local selection_color = 15
    line(top_left.x, top_left.y, top_right.x, top_right.y, selection_color)
    line(top_right.x, top_right.y, bottom_right.x, bottom_right.y, selection_color)
    line(bottom_right.x, bottom_right.y, bottom_left.x, bottom_left.y, selection_color)
    return line(bottom_left.x, bottom_left.y, top_left.x, top_left.y, selection_color)
  end
end
btn_connect = function(btn1, btn2, dir)
  if dir == UP then
    btn1.up = btn2
    btn2.down = btn1
  end
  if dir == DOWN then
    btn1.down = btn2
    btn2.up = btn1
  end
  if dir == LEFT then
    btn1.left = btn2
    btn2.right = btn1
  end
  if dir == RIGHT then
    btn1.right = btn2
    btn2.left = btn1
  end
end
can_place = function(grid_pos, sz)
  if grid_pos.x < 1 or grid_pos.y < 1 or grid_pos.x > map_sz.x or grid_pos.y > map_sz.y then
    return false
  end
  if rail_grid[grid_pos.y][grid_pos.x] ~= -1 then
    return false
  end
  for i, v in ipairs(entity_list) do
    local _continue_0 = false
    repeat
      if not is_in_list(BUILDING_ENTITY_LIST, v.type_tag) then
        _continue_0 = true
        break
      end
      local pos = vecmul(grid_pos, 8)
      if rect_collide(v.pos, v.sz, pos, sz) then
        return false
      end
      _continue_0 = true
    until true
    if not _continue_0 then
      break
    end
  end
  return true
end
rail_new = function(pos)
  if money_count < RAIL_COST then
    return 
  end
  local grid_pos = vecdivdiv(pos, 8)
  if not can_place(grid_pos, vecnew(8, 8)) then
    return 
  end
  money_count = money_count - RAIL_COST
  local rail = entity_new(ENTITY_RAIL, pos, vecnew(8, 8), rail_update, rail_draw)
  rail.rail_type_tag = RAIL_HORIZONTAL
  rail.rm_next_frame = false
  rail_grid[grid_pos.y][grid_pos.x] = rail
  set_rail_type_tag(grid_pos.x, grid_pos.y)
  update_surround_rail_type_tag(grid_pos.x, grid_pos.y)
  train_check_path_all()
  station_check_path_all()
  return rail
end
local rail_rm
rail_rm = function(rail)
  rail.rm_next_frame = true
  local grid_pos = vecdivdiv(rail.pos, 8)
  if rail_grid[grid_pos.y][grid_pos.x] ~= -1 then
    rail_grid[grid_pos.y][grid_pos.x] = -1
    train_check_path_all()
    station_check_path_all()
  end
  return update_surround_rail_type_tag(grid_pos.x, grid_pos.y)
end
rail_rm_xy = function(grid_pos)
  local x = grid_pos.x
  local y = grid_pos.y
  if rail_grid[y][x] ~= -1 then
    rail_grid[y][x].rm_next_frame = true
    rail_grid[y][x] = -1
    train_check_path_all()
    station_check_path_all()
  end
  return update_surround_rail_type_tag(x, y)
end
set_rail_type_tag = function(x, y)
  local rail = rail_grid[y][x]
  local up = false
  local down = false
  local left = false
  local right = false
  local left_type_tag
  left, left_type_tag = have_rail(x - 1, y)
  local right_type_tag
  right, right_type_tag = have_rail(x + 1, y)
  local up_type_tag
  up, up_type_tag = have_rail(x, y - 1)
  local down_type_tag
  down, down_type_tag = have_rail(x, y + 1)
  local total = 0
  if up then
    total = total + 1
  end
  if down then
    total = total + 1
  end
  if left then
    total = total + 1
  end
  if right then
    total = total + 1
  end
  if total == 4 then
    rail.rail_type_tag = RAIL_4
  end
  if total == 3 then
    if not up then
      rail.rail_type_tag = RAIL_3_DOWN
    end
    if not down then
      rail.rail_type_tag = RAIL_3_UP
    end
    if not left then
      rail.rail_type_tag = RAIL_3_RIGHT
    end
    if not right then
      rail.rail_type_tag = RAIL_3_LEFT
    end
  end
  if total == 2 then
    if up and left then
      rail.rail_type_tag = RAIL_DOWN_RIGHT
    end
    if up and right then
      rail.rail_type_tag = RAIL_DOWN_LEFT
    end
    if down and left then
      rail.rail_type_tag = RAIL_UP_RIGHT
    end
    if down and right then
      rail.rail_type_tag = RAIL_UP_LEFT
    end
    if up and down then
      rail.rail_type_tag = RAIL_VERTICAL
    end
    if right and left then
      rail.rail_type_tag = RAIL_HORIZONTAL
    end
  end
  if total == 1 then
    if up or down then
      rail.rail_type_tag = RAIL_VERTICAL
    end
    if left or right then
      rail.rail_type_tag = RAIL_HORIZONTAL
    end
  end
end
update_surround_rail_type_tag = function(x, y)
  for ix = x - 1, x + 1 do
    for iy = y - 1, y + 1 do
      local _continue_0 = false
      repeat
        if ix == x and iy == y then
          _continue_0 = true
          break
        end
        if ix < 1 or ix > map_sz.x or iy < 1 or iy > map_sz.y then
          _continue_0 = true
          break
        end
        if rail_grid[iy][ix] == -1 then
          _continue_0 = true
          break
        end
        set_rail_type_tag(ix, iy)
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
  end
end
have_rail = function(x, y)
  local b = true
  local type_tag = -1
  if x < 1 then
    return false, -1
  end
  if y < 1 then
    return false, -1
  end
  if x > map_sz.x then
    return false, -1
  end
  if y > map_sz.y then
    return false, -1
  end
  if rail_grid[y][x] == -1 then
    return false, -1
  end
  return true, rail_grid[y][x].rail_type_tag
end
rail_update = function(i, rail)
  if rail.rm_next_frame then
    return table.remove(entity_list, i)
  end
end
rail_draw = function(rail)
  local draw_pos = get_draw_pos(rail.pos)
  local spr_id = -1
  local flip = 0
  if rail.rail_type_tag == RAIL_HORIZONTAL then
    spr_id = 1
  end
  if rail.rail_type_tag == RAIL_VERTICAL then
    spr_id = 2
  end
  if rail.rail_type_tag == RAIL_UP_LEFT then
    spr_id = 4
  end
  if rail.rail_type_tag == RAIL_UP_RIGHT then
    spr_id = 4
    flip = 1
  end
  if rail.rail_type_tag == RAIL_DOWN_LEFT then
    spr_id = 3
  end
  if rail.rail_type_tag == RAIL_DOWN_RIGHT then
    spr_id = 3
    flip = 1
  end
  if rail.rail_type_tag == RAIL_3_UP then
    spr_id = 7
  end
  if rail.rail_type_tag == RAIL_3_DOWN then
    spr_id = 6
  end
  if rail.rail_type_tag == RAIL_3_LEFT then
    spr_id = 5
    flip = 1
  end
  if rail.rail_type_tag == RAIL_3_RIGHT then
    spr_id = 5
  end
  if rail.rail_type_tag == RAIL_4 then
    spr_id = 8
  end
  return draw(spr_id, draw_pos.x, draw_pos.y, 0, 1, flip, 0, 1, 1, rail.pos, -1)
end
station_new = function(pos)
  if money_count < STATION_COST then
    return 
  end
  local grid_pos = vecdivdiv(pos, 8)
  if not can_place(grid_pos, vecnew(8, 8)) then
    return 
  end
  if cursor.pos.x ~= 8 and cursor.pos.x ~= map_sz.x * 8 then
    return 
  end
  money_count = money_count - STATION_COST
  local station = entity_new(ENTITY_STATION, pos, vecnew(8, 8), station_update, station_draw)
  station.rm_next_frame = false
  station.have_path = false
  station.created_at = t
  train_check_path_all()
  station_check_path_all()
  return station
end
local station_rm
station_rm = function(station)
  for i, v in ipairs(entity_list) do
    local _continue_0 = false
    repeat
      do
        if v.type_tag ~= ENTITY_STATION then
          _continue_0 = true
          break
        end
        if station ~= v then
          _continue_0 = true
          break
        end
        station.rm_next_frame = true
        train_check_path_all()
        station_check_path_all()
        return 
      end
      _continue_0 = true
    until true
    if not _continue_0 then
      break
    end
  end
end
station_rm_xy = function(grid_pos)
  for i, v in ipairs(entity_list) do
    local _continue_0 = false
    repeat
      do
        if v.type_tag ~= ENTITY_STATION then
          _continue_0 = true
          break
        end
        local v_grid_pos = vecdivdiv(v.pos, 8)
        if not vecequals(grid_pos, v_grid_pos) then
          _continue_0 = true
          break
        end
        v.rm_next_frame = true
        train_check_path_all()
        station_check_path_all()
        return 
      end
      _continue_0 = true
    until true
    if not _continue_0 then
      break
    end
  end
end
station_update = function(i, station)
  station_create_train(station)
  if station.rm_next_frame then
    return table.remove(entity_list, i)
  end
end
station_create_train = function(station)
  if not station.have_path then
    return 
  end
  if (t - station.created_at) % (60 * 8) ~= 0 then
    return 
  end
  local grid_pos = vecdivdiv(station.pos, 8)
  local x = grid_pos.x
  local y = grid_pos.y
  local right = false
  local up = false
  local down = false
  if x + 1 <= map_sz.x then
    if rail_grid[y][x + 1] ~= -1 then
      right = true
    end
  end
  if y - 1 >= 1 then
    if rail_grid[y - 1][x] ~= -1 then
      up = true
    end
  end
  if y + 1 <= map_sz.y then
    if rail_grid[y + 1][x] ~= -1 then
      down = true
    end
  end
  local total = 0
  if right then
    total = total + 1
  end
  if up then
    total = total + 1
  end
  if down then
    total = total + 1
  end
  local choose_right = false
  local choose_up = false
  local choose_down = false
  if total == 1 then
    if right then
      choose_right = true
    end
    if up then
      choose_up = true
    end
    if down then
      choose_down = true
    end
  end
  if total == 2 then
    if right and up then
      if dice(1, 2) then
        choose_right = true
      else
        choose_up = true
      end
    end
    if right and down then
      if dice(1, 2) then
        choose_right = true
      else
        choose_down = true
      end
    end
    if up and down then
      if dice(1, 2) then
        choose_up = true
      else
        choose_down = true
      end
    end
  end
  if total == 3 then
    local rnd = rndi(1, 3)
    if rnd == 1 then
      choose_right = true
    elseif rnd == 2 then
      choose_up = true
    elseif rnd == 3 then
      choose_down = true
    end
  end
  if choose_right then
    return train_new(vecnew(station.pos.x + 8, station.pos.y))
  elseif choose_up then
    return train_new(vecnew(station.pos.x, station.pos.y - 8))
  elseif choose_down then
    return train_new(vecnew(station.pos.x, station.pos.y + 8))
  end
end
station_draw = function(station)
  local draw_pos = get_draw_pos(station.pos)
  if station.pos.x == 8 and not station.have_path then
    draw(64, draw_pos.x + 3, draw_pos.y - 14, 0, 1, 0, 0, 1, 2, vecnew(0, 0), 10)
  end
  return draw(9, draw_pos.x, draw_pos.y - 8, 0, 1, 0, 0, 1, 2, station.pos, 0)
end
station_check_path_all = function()
  for i, v in ipairs(entity_list) do
    local _continue_0 = false
    repeat
      if v.type_tag ~= ENTITY_STATION then
        _continue_0 = true
        break
      end
      station_check_path(v)
      _continue_0 = true
    until true
    if not _continue_0 then
      break
    end
  end
end
station_check_path = function(station)
  local path = train_get_path(station)
  if #path <= 0 then
    station.have_path = false
  else
    station.have_path = true
  end
end
train_new = function(pos)
  local train = entity_new(ENTITY_TRAIN, pos, vecnew(8, 8), train_update, train_draw)
  train.path = train_get_path(train)
  train.served = fasle
  return train
end
train_update = function(i, train)
  train_move(train)
  return train_check_rm(i, train)
end
train_move = function(train)
  if #train.path <= 0 then
    return 
  end
  local grid_pos = train.path[#train.path]
  local pos = vecmul(grid_pos, 8)
  local diff = vecsub(pos, train.pos)
  local move = vecnew(0, 0)
  if diff.x > 0 then
    move.x = 0.5
  elseif diff.x < 0 then
    move.x = -0.5
  elseif diff.y > 0 then
    move.y = 0.5
  elseif diff.y < 0 then
    move.y = -0.5
  end
  if veclengthsqr(diff) < 0.1 then
    table.remove(train.path, #train.path)
  end
  train.pos = vecadd(train.pos, move)
end
train_get_path = function(train)
  local grid_pos = vecdivdiv(train.pos, 8)
  local path = { }
  local grid = { }
  for iy = 1, map_sz.y do
    table.insert(grid, { })
    for ix = 1, map_sz.x do
      table.insert(grid[iy], false)
    end
  end
  recursion_train_get_path(path, grid, grid_pos)
  return path
end
recursion_train_get_path = function(path, grid, xy)
  grid[xy.y][xy.x] = true
  local dir_list = {
    vecnew(-1, 0),
    vecnew(1, 0),
    vecnew(0, -1),
    vecnew(0, 1)
  }
  dir_list = list_shuffle(dir_list)
  for i, v in ipairs(dir_list) do
    local _continue_0 = false
    repeat
      local next_pos = vecadd(xy, v)
      if next_pos.x < 1 or next_pos.y < 1 or next_pos.x > map_sz.x or next_pos.y > map_sz.y then
        _continue_0 = true
        break
      end
      if grid[next_pos.y][next_pos.x] == true then
        _continue_0 = true
        break
      end
      if next_pos.x == map_sz.x then
        for j, v2 in ipairs(entity_list) do
          local _continue_1 = false
          repeat
            do
              if v2.type_tag ~= ENTITY_STATION then
                _continue_1 = true
                break
              end
              if v2.rm_next_frame then
                _continue_1 = true
                break
              end
              if not vecequals(next_pos, vecdivdiv(v2.pos, 8)) then
                _continue_1 = true
                break
              end
              table.insert(path, next_pos)
              return true
            end
            _continue_1 = true
          until true
          if not _continue_1 then
            break
          end
        end
      end
      if rail_grid[next_pos.y][next_pos.x] == -1 then
        _continue_0 = true
        break
      end
      if rail_grid[next_pos.y][next_pos.x].rm_next_frame then
        _continue_0 = true
        break
      end
      if recursion_train_get_path(path, grid, next_pos) == true then
        table.insert(path, next_pos)
        return true
      end
      _continue_0 = true
    until true
    if not _continue_0 then
      break
    end
  end
  return false
end
train_check_rm = function(i, train)
  local grid_pos = vecdivdiv(train.pos, 8)
  if rail_grid[grid_pos.y][grid_pos.x] == -1 then
    table.remove(entity_list, i)
    return 
  end
  for j, v in ipairs(entity_list) do
    local _continue_0 = false
    repeat
      do
        if v.type_tag ~= ENTITY_STATION then
          _continue_0 = true
          break
        end
        if v.pos.x == 8 then
          _continue_0 = true
          break
        end
        if not rect_collide(train.pos, train.sz, v.pos, v.sz) then
          _continue_0 = true
          break
        end
        table.remove(entity_list, i)
        return 
      end
      _continue_0 = true
    until true
    if not _continue_0 then
      break
    end
  end
end
train_draw = function(train)
  local draw_pos = get_draw_pos(train.pos)
  if #train.path == 0 then
    draw(64, draw_pos.x + 3, draw_pos.y - 16, 0, 1, 0, 0, 1, 2, vecnew(0, 0), 10)
  end
  if #train.path ~= 0 and not train.served then
    draw(65, draw_pos.x + 2, draw_pos.y - 10, 0, 1, 0, 0, 1, 1, vecnew(0, 0), 10)
  end
  return draw(10, draw_pos.x, draw_pos.y - 10, 0, 1, 0, 0, 1, 2, vecadd(train.pos, vecnew(0, 0)), 0)
end
train_check_path_all = function()
  for i, v in ipairs(entity_list) do
    local _continue_0 = false
    repeat
      if v.type_tag ~= ENTITY_TRAIN then
        _continue_0 = true
        break
      end
      v.path = train_get_path(v)
      _continue_0 = true
    until true
    if not _continue_0 then
      break
    end
  end
end
local RESTAURANT_SERVE_COUNT_MAX = 8
local SHOW_MONEY_MARK_FOR = 60
restaurant_new = function(pos)
  if money_count < RESTAURANT_COST then
    return 
  end
  local grid_pos = vecdivdiv(pos, 8)
  if not can_place(grid_pos, vecnew(16, 16)) then
    return 
  end
  money_count = money_count - RESTAURANT_COST
  local restaurant = entity_new(ENTITY_RESTAURANT, pos, vecnew(16, 16), restaurant_update, restaurant_draw)
  restaurant.rm_next_frame = false
  restaurant.serve_count = RESTAURANT_SERVE_COUNT_MAX
  restaurant.show_money_mark = 0
  return restaurant
end
restaurant_rm_xy = function(grid_pos)
  for i, v in ipairs(entity_list) do
    local _continue_0 = false
    repeat
      do
        if v.type_tag ~= ENTITY_RESTAURANT then
          _continue_0 = true
          break
        end
        if not rect_collide(vecmul(grid_pos, 8), vecnew(8, 8), v.pos, v.sz) then
          _continue_0 = true
          break
        end
        v.rm_next_frame = true
        return 
      end
      _continue_0 = true
    until true
    if not _continue_0 then
      break
    end
  end
end
restaurant_update = function(i, restaurant)
  restaurant_serve(restaurant)
  restaurant_refill(restaurant)
  restaurant.show_money_mark = restaurant.show_money_mark - 1
  if restaurant.rm_next_frame then
    return table.remove(entity_list, i)
  end
end
restaurant_serve = function(restaurant)
  if restaurant.serve_count == 0 then
    return 
  end
  for j, v in ipairs(entity_list) do
    local _continue_0 = false
    repeat
      if v.type_tag ~= ENTITY_TRAIN then
        _continue_0 = true
        break
      end
      if not rect_collide(vecadd(restaurant.pos, vecnew(-8, -8)), vecnew(32, 32), v.pos, v.sz) then
        _continue_0 = true
        break
      end
      if v.served then
        _continue_0 = true
        break
      end
      v.served = true
      money_count = money_count + 1
      restaurant.show_money_mark = SHOW_MONEY_MARK_FOR
      restaurant.serve_count = restaurant.serve_count - 1
      _continue_0 = true
    until true
    if not _continue_0 then
      break
    end
  end
end
restaurant_refill = function(restaurant)
  if restaurant.serve_count > 0 then
    return 
  end
  for i, v in ipairs(entity_list) do
    local _continue_0 = false
    repeat
      do
        if v.type_tag ~= ENTITY_REFILL then
          _continue_0 = true
          break
        end
        if v.rm_next_frame then
          _continue_0 = true
          break
        end
        if not rect_collide(vecadd(restaurant.pos, vecnew(-8, -8)), vecnew(32, 32), v.pos, v.sz) then
          _continue_0 = true
          break
        end
        v.rm_next_frame = true
        restaurant.serve_count = RESTAURANT_SERVE_COUNT_MAX
        return 
      end
      _continue_0 = true
    until true
    if not _continue_0 then
      break
    end
  end
end
restaurant_draw = function(restaurant)
  local draw_pos = get_draw_pos(restaurant.pos)
  draw(11, draw_pos.x, draw_pos.y - 8, 0, 1, 0, 0, 2, 3, vecadd(restaurant.pos, vecnew(8, 8)), 0)
  local bar_w = 16
  draw_rect(draw_pos.x, draw_pos.y - 4, bar_w, 2, 14, vecnew(0, 0), 11)
  local bar_filled_w = bar_w * (restaurant.serve_count / RESTAURANT_SERVE_COUNT_MAX)
  draw_rect(draw_pos.x, draw_pos.y - 4, bar_filled_w, 2, 6, vecnew(0, 0), 12)
  if restaurant.show_money_mark > 0 then
    return draw_text('+1', draw_pos.x + 4, draw_pos.y - 12, 5, false, 1, true, vecnew(0, 0), 10)
  end
end
refill_new = function(pos)
  if money_count < REFILL_COST then
    return 
  end
  local grid_pos = vecdivdiv(pos, 8)
  if not can_place(grid_pos, vecnew(8, 8)) then
    return 
  end
  money_count = money_count - REFILL_COST
  local refill = entity_new(ENTITY_REFILL, pos, vecnew(8, 8), refill_update, refill_draw)
  refill.rm_next_frame = false
  return refill
end
refill_rm_xy = function(grid_pos)
  for i, v in ipairs(entity_list) do
    local _continue_0 = false
    repeat
      do
        if v.type_tag ~= ENTITY_REFILL then
          _continue_0 = true
          break
        end
        if not vecequals(grid_pos, vecdivdiv(v.pos, 8)) then
          _continue_0 = true
          break
        end
        v.rm_next_frame = true
        return 
      end
      _continue_0 = true
    until true
    if not _continue_0 then
      break
    end
  end
end
refill_update = function(i, refill)
  if refill.rm_next_frame then
    return table.remove(entity_list, i)
  end
end
refill_draw = function(refill)
  local draw_pos = get_draw_pos(refill.pos)
  return draw(13, draw_pos.x, draw_pos.y - 8, 0, 1, 0, 0, 1, 2, refill.pos, 0)
end
local FARM_CREATE_REFILL_COOLDOWN = 32 * 60
farm_new = function(pos)
  if money_count < FARM_COST then
    return 
  end
  local grid_pos = vecdivdiv(pos, 8)
  if not can_place(grid_pos, vecnew(16, 16)) then
    return 
  end
  money_count = money_count - FARM_COST
  local farm = entity_new(ENTITY_FARM, pos, vecnew(16, 16), farm_update, farm_draw)
  farm.rm_next_frame = false
  farm.until_refill = FARM_CREATE_REFILL_COOLDOWN
  return farm
end
farm_rm_xy = function(grid_pos)
  for i, v in ipairs(entity_list) do
    local _continue_0 = false
    repeat
      do
        if v.type_tag ~= ENTITY_FARM then
          _continue_0 = true
          break
        end
        if not rect_collide(vecmul(grid_pos, 8), vecnew(8, 8), v.pos, v.sz) then
          _continue_0 = true
          break
        end
        v.rm_next_frame = true
        return 
      end
      _continue_0 = true
    until true
    if not _continue_0 then
      break
    end
  end
end
farm_update = function(i, farm)
  farm.until_refill = farm.until_refill - 1
  if farm.until_refill <= 0 then
    farm.until_refill = FARM_CREATE_REFILL_COOLDOWN
    farm_create_refill(farm)
  end
  if farm.rm_next_frame then
    return table.remove(entity_list, i)
  end
end
farm_create_refill = function(farm)
  local farm_grid_pos = vecdivdiv(farm.pos, 8)
  local pos_list = { }
  for x = -1, 2 do
    for y = -1, 2 do
      local _continue_0 = false
      repeat
        if not can_place(vecadd(farm_grid_pos, vecnew(x, y)), vecnew(8, 8)) then
          _continue_0 = true
          break
        end
        table.insert(pos_list, vecnew(x, y))
        _continue_0 = true
      until true
      if not _continue_0 then
        break
      end
    end
  end
  if #pos_list == 0 then
    return 
  end
  local i = rndi(1, #pos_list)
  return refill_new(vecadd(farm.pos, vecmul(pos_list[i], 8)))
end
farm_draw = function(farm)
  local draw_pos = get_draw_pos(farm.pos)
  draw(45, draw_pos.x, draw_pos.y - 8, 0, 1, 0, 0, 2, 3, vecadd(farm.pos, vecnew(8, 8)), 0)
  local bar_w = 16
  draw_rect(draw_pos.x, draw_pos.y - 4, bar_w, 2, 14, vecnew(0, 0), 11)
  local bar_filled_w = (1 - (farm.until_refill / FARM_CREATE_REFILL_COOLDOWN)) * bar_w
  return draw_rect(draw_pos.x, draw_pos.y - 4, bar_filled_w, 2, 6, vecnew(0, 0), 12)
end

-- <TILES>
-- 001:ddddddddeeeeeeee0ff00ff00ee00ee00ee00ee0ddddddddeeeeeeee0ff00ff0
-- 002:0d0000d0edeeeedeedeeeedefdffffdf0d0000d0edeeeedeedeeeedefdffffdf
-- 003:0d0000dd0d000eee0d00eeef0d0eeef00deeef000ddddddd0eeeeeee0ff00000
-- 004:0ddddddd0deeeeee0deee0000dfeee000d0feee00d00fedd0d000fde0d0000df
-- 005:0d0000dd0de00eee0deeeeef0deeeef00dfeef000deefedd0deffede0df00fd0
-- 006:ddddddddeeeeeeee0ee00ee00eeeeee00feeeef0ddfeeeddedffeede0df0fed0
-- 007:dd0000ddeee00eeefeeeeeef0feeeef000feef00ddddddddeeeeeeee0ff00ff0
-- 008:dd0000ddeee00eeefeeeeeef0feeeef000feee00ddefeeddedeffede0df00fd0
-- 009:00000000000000000aaaaaa0aaaa9aaaaaaaa9aaa999999aaaaaa9aaaaaa9aaa
-- 010:0000000000000000000000000000000000000000aaaaaaaaaa9999aaa999999a
-- 011:0000003300000333000032330003223300322233032222333222223332222233
-- 012:3300000033300000332300003322300033222300332222303322222333222223
-- 013:0000000000000000000000000000000033333333344444333444434334433443
-- 016:000000000000e000000ee00000eee000000ee0000000e0000000000000000000
-- 017:00000000000e000000eee0000eeeee0000eee00000eee0000000000000000000
-- 018:00000000000e000000eee0000ee0ee0000eee000000e00000000000000000000
-- 025:aaaaaaaaa999999a99999999999999999cccccc99cccccc99999999999999999
-- 026:a999999aa999999aaa9999aaaaaaaaaa99999999ccc99cccccc99ccc99999999
-- 027:3222233232223322322332cc323322cc333223cc332233cc333333330e222222
-- 028:2332222322332223cc233223cc223323cc322333cc33223333333333222222e0
-- 029:3434444333444443333333332222222222233332233223322333322222222222
-- 032:000000000000000000000000000000000000dddd0000eeee00000ff000000ee0
-- 033:00000000000000000000000000000000dddd0000eeee00000ff000000ee00000
-- 034:0000000000000000000000000000000000000003000000320000032c0000333c
-- 035:000000000000000000000000000000003000000023000000c2300000c3330000
-- 036:00000000000000000000000000000000000000aa00000aaa00000aaa00000aaa
-- 037:00000000000000000000000000000000aa000000aaa00000aaa00000aaa00000
-- 038:0000000000000000000000000000000000000333000003440000034400000333
-- 039:0000000000000000000000000000000033300000443000004430000033300000
-- 040:000000000000000000000050000005550000d5550000de5e0000d0300000d000
-- 041:00000000000000000000000000000000dddd0000eeed00006666000066660000
-- 043:0e3333330e3333330e33fff30e33fff30e33fff30e33fff30eeeeeee0fffffff
-- 044:333333e0333333e03ccc33e03ccc33e0333333e0333333e0eeeeeee0fffffff0
-- 045:00005500000055000005555000055550005555550056556500656656dd665566
-- 046:00000000000000000000000000000000000000000000000000000000dddddddd
-- 048:00000ee00000dddd0000eeee00000ff000000000000000000000000000000000
-- 049:0ee00000dddd0000eeee00000ff0000000000000000000000000000000000000
-- 050:0000022200000333000003ee000003ee00000000000000000000000000000000
-- 051:22200000333000003c3000003330000000000000000000000000000000000000
-- 052:00000a9900000999000009cc0000099900000000000000000000000000000000
-- 053:99a0000099900000cc9000009990000000000000000000000000000000000000
-- 054:0000022200000233000002330000022200000000000000000000000000000000
-- 055:2220000033200000332000002220000000000000000000000000000000000000
-- 056:0000d0000000d0000000dddd0000eeee00000000000000000000000000000000
-- 057:6666000077770000777700007777000000000000000000000000000000000000
-- 061:de666666d0066660d0003300d0003300d0000000d0000006d0333306d0344306
-- 062:eeeeeeed0000000d0000000d0000000d0000000d666666666666666666666666
-- 064:2200000022000000220000002200000022000000220000000000000000000000
-- 065:6666000065560000666600000000000000000000000000000000000000000000
-- 077:d0333306d0222206d0233206d0222207d0000007d0000007ddddddd7eeeeeee7
-- 078:6666666666666666666666667777777777777777777777777777777777777777
-- 080:2200000022000000000000000000000000000000000000000000000000000000
-- </TILES>

-- <MAP>
-- 002:000010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 003:000000000000000020000000000000000040101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 004:000000000000000020000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 005:000000000000000020000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 006:000000000000000030101010101010000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 007:000020000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 008:000020000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 009:000020000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 010:000050101010101010601010101070101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 011:000020000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 012:000020000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 013:000020000000000010801000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 014:000020000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </MAP>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <TRACKS>
-- 000:100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </TRACKS>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

