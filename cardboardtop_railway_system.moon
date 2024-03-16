-- title:   Box Town
-- author:  TripleCubes
-- license: MIT License
-- script:  moon

local create_nav
local connect_to_nav

local bkg_draw
local box_draw

local create_menu_build
local building_btn_connect
local building_btn_connect_around
local get_building_btn_from_xy

local game_controls_update
local dpad_mode_controls
local menu_controls
local cursor_controls
local dpad_camera_update
local dpad_cursor_update

local game_controls_draw
local cursor_draw

local get_draw_pos

local ui_new
local ui_list_update
local ui_list_draw

local open_menu
local close_all_menus
local menu_new
local menu_update
local menu_draw
local menu_add_ui

local select_btn
local select_building_btn
local btn_new
local btn_update
local btn_draw
local btn_connect

local entity_new
local entity_list_update
local entity_list_draw

local rail_new
local rail_rm
local rail_rm_xy
local set_rail_type_tag
local update_surround_rail_type_tag
local have_rail
local rail_update
local rail_draw

local vecnew
local veccopy
local vecadd
local vecsub
local vecmul
local vecdiv
local vecdivdiv
local vecmod
local vecparam

local rect_collide
local in_rect

WINDOW_W = 240
WINDOW_H = 136

UP = 0
DOWN = 1
LEFT = 2
RIGHT = 3

ENTITY_RAIL = 0

rail_grid = {}
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

t = 0
map_sz = { x: 0, y: 0 }
entity_list = {}
camera = { pos: {} }
cursor = { pos: {} }
cursor_move_hold_0 = 0
cursor_move_hold_1 = 0
cursor_move_hold_2 = 0
cursor_move_hold_3 = 0
CURSOR_MOVE_HOLD_TIME = 30

DPAD_CAMERA = 0
DPAD_CURSOR = 1
dpad_mode = DPAD_CURSOR

UI_MENU = 0
UI_BTN = 1

ui_list = {}

menu_build = {}
menu_opening = nil

btn_selected = nil
btn_switched = false

BUILDING_RAIL = 0
BUILDING_RESTAURANT = 1
building_btn_list = {}
building_btn_selected = nil

TAB_BTN_MARGIN_LEFT = 4
TAB_BTN_MARGIN_TOP = 4
TAB_BTN_SPACING_H = 12
TAB_BTN_SZ = { x: 32, y: 8 }
CARD_BTN_MARGIN_LEFT = TAB_BTN_MARGIN_LEFT + TAB_BTN_SZ.x + 4
CARD_BTN_MARGIN_TOP = TAB_BTN_MARGIN_TOP
CARD_BTN_SPACING_SZ = { x: 20, y: 20 }
CARD_BTN_SZ = { x: 16, y: 16 }

export BOOT = ->
	camera.pos = vecnew(0, 0)
	cursor.pos = vecnew(8, 8)

	create_menu_build()

	map_sz = vecnew(24, 16)
	for y = 1, map_sz.y
		table.insert(rail_grid, {})
		for x = 1, map_sz.x
			table.insert(rail_grid[y], -1)

export TIC = ->
	game_controls_update()
	ui_list_update()
	entity_list_update()

	cls(0)
	bkg_draw()
	entity_list_draw()
	game_controls_draw()
	ui_list_draw()

	btn_switched = false
	t += 1

create_nav = (menu) ->
	y = TAB_BTN_MARGIN_TOP
	btn_back = btn_new(vecnew(TAB_BTN_MARGIN_LEFT, y), TAB_BTN_SZ, 16, vecnew(1, 1), 'Back', (btn) ->
		close_all_menus()
	)
	y += TAB_BTN_SPACING_H
	btn_build = btn_new(vecnew(TAB_BTN_MARGIN_LEFT, y), TAB_BTN_SZ, 17, vecnew(1, 1), 'Build', (btn) ->
		trace('btn 2 pressed')
	)
	y += TAB_BTN_SPACING_H
	btn_game = btn_new(vecnew(TAB_BTN_MARGIN_LEFT, y), TAB_BTN_SZ, 18, vecnew(1, 1), 'Game', (btn) ->
		trace('btn 2 pressed')
	)

	nav_btn_list = { btn_back, btn_build, btn_game, }

	btn_connect(btn_back, btn_build, DOWN)
	btn_connect(btn_build, btn_game, DOWN)
	menu_add_ui(menu, btn_back)
	menu_add_ui(menu, btn_build)
	menu_add_ui(menu, btn_game)

	return nav_btn_list

connect_to_nav = (nav_btn_list, btn) ->
	for i, v in ipairs(nav_btn_list)
		v.right = btn
	btn.left = nav_btn_list[1]

bkg_draw = ->
	box_draw()

box_draw = ->
	draw_pos = get_draw_pos(vecnew(8, 8))
	rect(draw_pos.x, draw_pos.y, map_sz.x * 8, map_sz.y * 8, 4)
	rect(draw_pos.x, draw_pos.y + map_sz.y * 8, map_sz.x * 8, 20 * 8, 3)

create_menu_build = ->
	menu_build = menu_new(nil, vecnew(0, WINDOW_H - 60))
	menu = menu_build

	x = CARD_BTN_MARGIN_LEFT
	y = CARD_BTN_MARGIN_TOP
	btn_rail = btn_new(vecnew(x, y), CARD_BTN_SZ, 32, vecnew(2, 2), '', (btn) ->
		select_building_btn(btn)
	)
	select_building_btn(btn_rail)
	btn_rail.building_type_tag = BUILDING_RAIL

	x += CARD_BTN_SPACING_SZ.x
	btn_restaurant = btn_new(vecnew(x, y), CARD_BTN_SZ, 34, vecnew(2, 2), '', (btn) ->
		select_building_btn(btn)
	)
	btn_restaurant.building_type_tag = BUILDING_RESTAURANT

	building_btn_list = { btn_rail, btn_restaurant }
	building_btn_connect(2, 1)

	menu_add_ui(menu, btn_rail)
	menu_add_ui(menu, btn_restaurant)

	nav_btn_list = create_nav(menu)
	nav_btn_list[2].highlight = true
	connect_to_nav(nav_btn_list, btn_rail)

building_btn_connect = (grid_w, grid_h) ->
	for x = 1, grid_w
		for y = 1, grid_h
			building_btn_connect_around(grid_w, grid_h, x, y)

building_btn_connect_around = (grid_w, grid_h, x, y) ->
	btn = get_building_btn_from_xy(grid_w, grid_h, x, y)
	if x - 1 >= 1
		btn.left = get_building_btn_from_xy(grid_w, grid_h, x - 1, y)
	if x + 1 <= grid_w
		btn.right = get_building_btn_from_xy(grid_w, grid_h, x + 1, y)
	if y - 1 >= 1
		btn.up = get_building_btn_from_xy(grid_w, grid_h, x, y - 1)
	if y + 1 <= grid_h
		btn.down = get_building_btn_from_xy(grid_w, grid_h, x, y + 1)

get_building_btn_from_xy = (grid_w, grid_h, x, y) ->
	i = (y - 1) * grid_w + (x - 1)
	btn = building_btn_list[i + 1]
	return btn

game_controls_update = ->
	dpad_mode_controls()
	menu_controls()
	cursor_controls()

dpad_mode_controls = ->
	if menu_opening != nil
		return

	if btnp(6)
		if dpad_mode == DPAD_CAMERA
			dpad_mode = DPAD_CURSOR
		else
			dpad_mode = DPAD_CAMERA

	if dpad_mode == DPAD_CAMERA
		dpad_camera_update()
	else
		dpad_cursor_update()

menu_controls = ->
	if btnp(7)
		if menu_opening == nil
			open_menu(menu_build)
		else
			close_all_menus()

cursor_controls = ->
	if menu_opening != nil
		return

	if dpad_mode != DPAD_CURSOR
		return

	if building_btn_selected.building_type_tag == BUILDING_RAIL
		if btn(4)
			rail_new(cursor.pos)
		if btn(5)
			pos = vecdivdiv(cursor.pos, 8)
			rail_rm_xy(pos.x, pos.y)
		
dpad_camera_update = ->
	if btn(0)
		camera.pos.y -= 1
	if btn(1)
		camera.pos.y += 1
	if btn(2)
		camera.pos.x -= 1
	if btn(3)
		camera.pos.x += 1

dpad_cursor_update = ->
	move = vecnew(0, 0)

	if btnp(0)
		move.y -= 8

	if btn(0)
		cursor_move_hold_0 += 1
		if cursor_move_hold_0 >= CURSOR_MOVE_HOLD_TIME and t % 4 == 0
			move.y -= 8
	else
		cursor_move_hold_0 = 0

	if btnp(1)
		move.y += 8

	if btn(1)
		cursor_move_hold_1 += 1
		if cursor_move_hold_1 >= CURSOR_MOVE_HOLD_TIME and t % 4 == 0
			move.y += 8
	else
		cursor_move_hold_1 = 0

	if btnp(2)
		move.x -= 8

	if btn(2)
		cursor_move_hold_2 += 1
		if cursor_move_hold_2 >= CURSOR_MOVE_HOLD_TIME and t % 4 == 0
			move.x -= 8
	else
		cursor_move_hold_2 = 0

	if btnp(3)
		move.x += 8

	if btn(3)
		cursor_move_hold_3 += 1
		if cursor_move_hold_3 >= CURSOR_MOVE_HOLD_TIME and t % 4 == 0
			move.x += 8
	else
		cursor_move_hold_3 = 0

	next_pos = vecadd(cursor.pos, move)
	if next_pos.x < 8 or next_pos.x > map_sz.x*8
		move.x = 0

	if next_pos.y < 8 or next_pos.y > map_sz.y*8
		move.y = 0

	cursor.pos = vecadd(cursor.pos, move)
		
game_controls_draw = ->
	cursor_draw()

cursor_draw = ->
	if dpad_mode == DPAD_CURSOR
		draw_pos = get_draw_pos(cursor.pos)
		line(draw_pos.x    , draw_pos.y    , draw_pos.x + 7, draw_pos.y    , 12)
		line(draw_pos.x + 7, draw_pos.y    , draw_pos.x + 7, draw_pos.y + 7, 12)
		line(draw_pos.x + 7, draw_pos.y + 7, draw_pos.x    , draw_pos.y + 7, 12)
		line(draw_pos.x    , draw_pos.y + 7, draw_pos.x    , draw_pos.y    , 12)

get_draw_pos = (vec) ->
	return vecsub(vec, camera.pos)

ui_new = (type_tag, update_func, draw_func) ->
	ui = {
		type_tag: type_tag,
		update: update_func,
		draw: draw_func,
	}
	table.insert(ui_list, ui)
	return ui

ui_list_update = ->
	for i = #ui_list, 1, -1
		v = ui_list[i]
		v.update(i, v)

ui_list_draw = ->
	for i, v in ipairs(ui_list)
		v.draw(v)

open_menu = (menu) ->
	menu_opening = menu
	btn_selected = menu.first_btn

close_all_menus = () ->
	menu_opening = nil
	btn_selected = nil

menu_new = (up_menu, pos) ->
	menu = ui_new(UI_MENU, menu_update, menu_draw)
	menu.up_menu = up_menu
	menu.sub_ui_list = {}
	menu.pos = veccopy(pos)
	menu.first_btn = nil
	return menu

menu_update = (i, menu) ->
	if menu_opening != menu
		return

	if btnp(5)
		if menu.up_menu == nil
			close_all_menus()
		else
			open_menu(menu.up_menu)

menu_draw = (menu) ->
	if menu_opening != menu
		return

	if menu == menu_build
		rect(menu.pos.x, menu.pos.y, WINDOW_W, WINDOW_H, 14)

menu_add_ui = (menu, ui) ->
	if menu.first_btn == nil and ui.type_tag == UI_BTN
		menu.first_btn = ui
	ui.menu = menu
	table.insert(menu.sub_ui_list, ui)

select_btn = (btn) ->
	btn_selected = btn

select_building_btn = (btn) ->
	for i, v in ipairs(building_btn_list)
		v.highlight = false
	btn.highlight = true

	building_btn_selected = btn

btn_new = (pos, sz, spr_id, spr_sz, txt, clicked_func) ->
	btn = ui_new(UI_BTN, btn_update, btn_draw)

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
	
btn_update = (i, btn) ->
	if btn_selected != btn
		return

	if btnp(4)
		btn.clicked_func(btn)

	if btn_switched
		return

	if btnp(0) and btn.up != nil
		btn_switched = true
		select_btn(btn.up)
	if btnp(1) and btn.down != nil
		btn_switched = true
		select_btn(btn.down)
	if btnp(2) and btn.left != nil
		btn_switched = true
		select_btn(btn.left)
	if btnp(3) and btn.right != nil
		btn_switched = true
		select_btn(btn.right)

btn_draw = (btn) ->
	if menu_opening != btn.menu
		return

	draw_pos = veccopy(btn.pos)
	if btn.menu != nil
		draw_pos = vecadd(draw_pos, btn.menu.pos)

	txt_pos = vecnew(0, 0)
	if btn.spr_id == -1
		txt_pos = vecadd(draw_pos, vecnew(1, 1))
	else
		txt_pos = vecadd(draw_pos, vecnew(8, 1))

	bkg_color = 12
	shading_color = 13
	if btn.highlight
		bkg_color = 4
		shading_color = 3
	rect(draw_pos.x, draw_pos.y, btn.sz.x, btn.sz.y, bkg_color)
	line(draw_pos.x, draw_pos.y + btn.sz.y, draw_pos.x + btn.sz.x - 1, draw_pos.y + btn.sz.y, shading_color)

	print(btn.txt, txt_pos.x, txt_pos.y, 14, false, 1, true)
	if btn.spr_id != -1
		spr(btn.spr_id, draw_pos.x, draw_pos.y, 0, 1, 0, 0, btn.spr_sz.x, btn.spr_sz.y)

	top_left = vecnew(draw_pos.x - 1, draw_pos.y - 1)
	top_right = vecnew(draw_pos.x + btn.sz.x, draw_pos.y - 1)
	bottom_right = vecnew(draw_pos.x + btn.sz.x, draw_pos.y + btn.sz.y)
	bottom_left = vecnew(draw_pos.x - 1, draw_pos.y + btn.sz.y)

--	if btn.highlight
--		highlight_color = 5
--		line(top_left.x, top_left.y, top_left.x + 3, top_left.y, highlight_color)
--		line(top_left.x, top_left.y, top_left.x, top_left.y + 3, highlight_color)
--		line(top_right.x, top_right.y, top_right.x - 3, top_right.y, highlight_color)
--		line(top_right.x, top_right.y, top_right.x, top_right.y + 3, highlight_color)
--		line(bottom_right.x, bottom_right.y, bottom_right.x - 3, bottom_right.y, highlight_color)
--		line(bottom_right.x, bottom_right.y, bottom_right.x, bottom_right.y - 3, highlight_color)
--		line(bottom_left.x, bottom_left.y, bottom_left.x + 3, bottom_left.y, highlight_color)
--		line(bottom_left.x, bottom_left.y, bottom_left.x, bottom_left.y - 3, highlight_color)

	if btn_selected == btn
		selection_color = 15
		line(top_left.x, top_left.y, top_right.x, top_right.y, selection_color)
		line(top_right.x, top_right.y, bottom_right.x, bottom_right.y, selection_color)
		line(bottom_right.x, bottom_right.y, bottom_left.x, bottom_left.y, selection_color)
		line(bottom_left.x, bottom_left.y, top_left.x, top_left.y, selection_color)

btn_connect = (btn1, btn2, dir) ->
	if dir == UP
		btn1.up = btn2
		btn2.down = btn1
	if dir == DOWN
		btn1.down = btn2
		btn2.up = btn1
	if dir == LEFT
		btn1.left = btn2
		btn2.right = btn1
	if dir == RIGHT
		btn1.right = btn2
		btn2.left = btn1

rail_new = (pos) ->
	grid_pos = vecdivdiv(pos, 8)
	if grid_pos.x < 1 or grid_pos.x > map_sz.x or grid_pos.y < 1 or grid_pos.y > map_sz.y
		return
	if rail_grid[grid_pos.y][grid_pos.x] != -1
		return

	rail = entity_new(ENTITY_RAIL, pos, vecnew(8, 8), rail_update, rail_draw)
	rail.rail_type_tag = RAIL_HORIZONTAL
	rail.rm_next_fram = false

	rail_grid[grid_pos.y][grid_pos.x] = rail

	set_rail_type_tag(grid_pos.x, grid_pos.y)
	update_surround_rail_type_tag(grid_pos.x, grid_pos.y)

	return rail

rail_rm = (rail) ->
	rail.rm_next_frame = true
	grid_pos = vecdivdiv(rail.pos, 8)
	rail_grid[grid_pos.y][grid_pos.x] = -1
	update_surround_rail_type_tag(grid_pos.x, grid_pos.y)

rail_rm_xy = (x, y) ->
	if rail_grid[y][x] != -1
		rail_grid[y][x].rm_next_frame = true
		rail_grid[y][x] = -1
	update_surround_rail_type_tag(x, y)

set_rail_type_tag = (x, y) ->
	rail = rail_grid[y][x]

	up = false
	down = false
	left = false
	right = false

	left , left_type_tag  = have_rail(x - 1, y)
	right, right_type_tag = have_rail(x + 1, y)
	up   , up_type_tag    = have_rail(x, y - 1)
	down , down_type_tag  = have_rail(x, y + 1)

	total = 0
	if up
		total += 1
	if down
		total += 1
	if left
		total += 1
	if right
		total += 1

	if total == 4
		rail.rail_type_tag = RAIL_4
	if total == 3
		if not up
			rail.rail_type_tag = RAIL_3_DOWN
		if not down
			rail.rail_type_tag = RAIL_3_UP
		if not left
			rail.rail_type_tag = RAIL_3_RIGHT
		if not right
			rail.rail_type_tag = RAIL_3_LEFT
	if total == 2
		if up and left
			rail.rail_type_tag = RAIL_DOWN_RIGHT
		if up and right
			rail.rail_type_tag = RAIL_DOWN_LEFT
		if down and left
			rail.rail_type_tag = RAIL_UP_RIGHT
		if down and right
			rail.rail_type_tag = RAIL_UP_LEFT
		if up and down
			rail.rail_type_tag = RAIL_VERTICAL
		if right and left
			rail.rail_type_tag = RAIL_HORIZONTAL
	if total == 1
		if up or down
			rail.rail_type_tag = RAIL_VERTICAL
		if left or right
			rail.rail_type_tag = RAIL_HORIZONTAL

update_surround_rail_type_tag = (x, y) ->
	for ix = x-1, x+1
		for iy = y-1, y+1
			if ix == x and iy == y
				continue
			if ix < 1 or ix > map_sz.x or iy < 1 or iy > map_sz.y
				continue
			if rail_grid[iy][ix] == -1
				continue
			set_rail_type_tag(ix, iy)
	
have_rail = (x, y) ->
	b = true
	type_tag = -1

	if x < 1
		return false, -1
	if y < 1
		return false, -1
	if x > map_sz.x
		return false, -1
	if y > map_sz.y
		return false, -1
	if rail_grid[y][x] == -1
		return false, -1

	return true, rail_grid[y][x].rail_type_tag

rail_update = (i, rail) ->
	if rail.rm_next_frame
		table.remove(entity_list, i)

rail_draw = (rail) ->
	draw_pos = get_draw_pos(rail.pos)
	spr_id = -1
	flip = 0
	if rail.rail_type_tag == RAIL_HORIZONTAL
		spr_id = 1
	if rail.rail_type_tag == RAIL_VERTICAL
		spr_id = 2
	if rail.rail_type_tag == RAIL_UP_LEFT
		spr_id = 4
	if rail.rail_type_tag == RAIL_UP_RIGHT
		spr_id = 4
		flip = 1
	if rail.rail_type_tag == RAIL_DOWN_LEFT
		spr_id = 3
	if rail.rail_type_tag == RAIL_DOWN_RIGHT
		spr_id = 3
		flip = 1
	if rail.rail_type_tag == RAIL_3_UP
		spr_id = 7
	if rail.rail_type_tag == RAIL_3_DOWN
		spr_id = 6
	if rail.rail_type_tag == RAIL_3_LEFT
		spr_id = 5
		flip = 1
	if rail.rail_type_tag == RAIL_3_RIGHT
		spr_id = 5
	if rail.rail_type_tag == RAIL_4
		spr_id = 8

	spr(spr_id, draw_pos.x, draw_pos.y, 0, 1, flip, 0, 1, 1)

entity_new = (type_tag, pos, sz, update_func, draw_func) ->
	e = {
		type_tag: type_tag,
		pos: veccopy(pos),
		sz: veccopy(sz),
		update: update_func,
		draw: draw_func,
	}
	table.insert(entity_list, e)
	return e

entity_list_update = () ->
	for i = #entity_list, 1, -1
		v = entity_list[i]
		v.update(i, v)

entity_list_draw = () ->
	for i, v in ipairs(entity_list)
		v.draw(v)

vecnew = (x, y) ->
	return { x: x, y: y }

veccopy = (vec) ->
	return { x: vec.x, y: vec.y }

vecadd = (vec_a, vec_b) ->
	return { x: vec_a.x + vec_b.x, y: vec_a.y + vec_b.y }

vecsub = (vec_a, vec_b) ->
	return { x: vec_a.x - vec_b.x, y: vec_a.y - vec_b.y }

vecmul = (vec, n) ->
	return { x: vec.x * n, y: vec.y * n }

vecdiv = (vec, n) ->
	return { x: vec.x / n, y: vec.y / n }

vecdivdiv = (vec, n) ->
	return { x: vec.x // n, y: vec.y // n }

vecmod = (vec, n) ->
	return { x: vec.x % n, y: vec.y % n }

vecparam = (vec) ->
	return vec.x, vec.y

rect_collide = (pos_a, sz_a, pos_b, sz_b) ->
	if pos_a.x + sz_a.x <= pos_b.x
		return false
	if pos_a.y + sz_a.y <= pos_b.y
		return false
	if pos_a.x >= pos_b.x + sz_b.x
		return false
	if pos_a.y >= pos_b.y + sz_b.y
		return false
	return true

in_rect = (pos, rect_pos, rect_sz) ->
	if pos.x < rect_pos.x
		return false
	if pos.y < rect_pos.y
		return false
	if pos.x >= rect_pos.x + rect_sz.x
		return false
	if pos.y >= rect_pos.y + rect_sz.y
		return false
	return true

-- <TILES>
-- 001:ddddddddeeeeeeee0ff00ff00ee00ee00ee00ee0ddddddddeeeeeeee0ff00ff0
-- 002:0d0000d0edeeeedeedeeeedefdffffdf0d0000d0edeeeedeedeeeedefdffffdf
-- 003:0d0000dd0d000eee0d00eeef0d0eeef00deeef000ddddddd0eeeeeee0ff00000
-- 004:0ddddddd0deeeeee0deee0000dfeee000d0feee00d00fedd0d000fde0d0000df
-- 005:0d0000dd0de00eee0deeeeef0deeeef00dfeef000deefedd0deffede0df00fd0
-- 006:ddddddddeeeeeeee0ee00ee00eeeeee00feeeef0ddfeeeddedffeede0df0fed0
-- 007:dd0000ddeee00eeefeeeeeef0feeeef000feef00ddddddddeeeeeeee0ff00ff0
-- 008:dd0000ddeee00eeefeeeeeef0feeeef000feee00ddefeeddedeffede0df00fd0
-- 016:000000000000e000000ee00000eee000000ee0000000e0000000000000000000
-- 017:00000000000e000000eee0000eeeee0000eee00000eee0000000000000000000
-- 018:00000000000e000000eee0000ee0ee0000eee000000e00000000000000000000
-- 032:000000000000000000000000000000000000dddd0000eeee00000ff000000ee0
-- 033:00000000000000000000000000000000dddd0000eeee00000ff000000ee00000
-- 034:000000000000000000000000000000cc00000cc40000cc43000cc43c000c444c
-- 035:000000000000000000000000cc0000004cc0000034cc0000c34cc000c444c000
-- 048:00000ee00000dddd0000eeee00000ff000000000000000000000000000000000
-- 049:0ee00000dddd0000eeee00000ff0000000000000000000000000000000000000
-- 050:000cc3330000c4440000c4dd0000c4dd0000cccc000000000000000000000000
-- 051:333cc000444c00004c4c0000444c0000cccc0000000000000000000000000000
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

