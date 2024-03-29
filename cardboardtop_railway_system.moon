-- title:   Cardboardtop Railway System
-- author:  TripleCubes
-- license: MIT License
-- script:  moon

export get_money_need
export map_expand

export get_camera_limit

export btn_str

export game_init
export init_buildings
export start_init
export kb_controller_init

export create_start_screen_menu
export create_kb_controller_menu

export game
export start
export kb_controller

export title_draw

export create_nav
export connect_to_nav

export bkg_draw
export box_draw

export create_menu_build
export create_building_btn
export create_menu_game
export draw_desc
export draw_building_costs
export draw_building_cost_under_btn
export building_btn_connect
export building_btn_connect_around
export get_building_btn_from_xy

export game_controls_update
export dpad_mode_controls
export menu_controls
export cursor_controls
export building_rm
export dpad_camera_update
export dpad_cursor_update

export game_controls_draw
export game_ui_draw
export draw_goals
export camera_arrows_draw
export bottom_left_card_draw
export help_text_draw
export help_text_draw_at
export cursor_draw
export get_cursor_sz

export get_draw_pos

export ui_new
export ui_list_update
export ui_list_draw

export open_menu
export close_all_menus
export menu_new
export menu_update
export menu_draw
export menu_add_ui

export select_btn
export select_building_btn
export btn_new
export btn_update
export btn_draw
export btn_connect

--local progress_bar_new
--local progress_bar_update
--local progress_bar_draw

export entity_new
export entity_list_update
export entity_list_draw

export can_place

export rail_new
export rail_rm
export rail_rm_xy
export set_rail_type_tag
export update_surround_rail_type_tag
export have_rail
export rail_update
export rail_draw

export station_new
export station_rm
export station_rm_xy
export station_update
export station_create_train
export station_draw
export station_check_path_all
export station_check_path

export train_new
export train_update
export train_move
export train_get_path
export recursion_train_get_path
export train_check_rm
export train_draw
export train_check_path_all

export restaurant_new
export restaurant_rm_xy
export restaurant_update
export restaurant_serve
export restaurant_refill
export restaurant_draw

export refill_new
export refill_rm_xy
export refill_update
export refill_draw

export farm_new
export farm_rm_xy
export farm_update
export farm_create_refill
export farm_draw

export arcade_new
export arcade_rm_xy
export arcade_update
export arcade_arcade
export arcade_draw

export draw
export draw_rect
export draw_text
export draw_list_draw

export vecequals
export vecnew
export veccopy
export vecadd
export vecsub
export vecmul
export vecdiv
export vecdivdiv
export vecmod
export veclength
export veclengthsqr
export vecparam

export rect_collide
export in_rect

export rndi
export rndf
export dice
export list_shuffle

export is_in_list
export find_in_list

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
ENTITY_ARCADE = 6

BUILDING_ENTITY_LIST = {
	ENTITY_RAIL,
	ENTITY_STATION,
	ENTITY_RESTAURANT,
	ENTITY_REFILL,
	ENTITY_FARM,
	ENTITY_ARCADE,
}

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

AT_GAME = 0
AT_START = 1
AT_KB_CONTROLLER = 2

lose = false
at = AT_KB_CONTROLLER
t = 0
map_sz = { x: 0, y: 0 }
entity_list = {}
draw_list = {}
camera = { pos: {} }
cursor = { pos: {} }
cursor_move_hold_0 = 0
cursor_move_hold_1 = 0
cursor_move_hold_2 = 0
cursor_move_hold_3 = 0
exit_menu_holding_5 = false
exit_menu_holding_4 = false
money_count = 6
time_remain = 0
TIME_REMAIN_MAX = 60*60*1.5
money_fullfilled = 0
wave = 0
show_goal_text = 0
CURSOR_MOVE_HOLD_TIME = 30

DPAD_CAMERA = 0
DPAD_CURSOR = 1
dpad_mode = DPAD_CURSOR

btn_kb = {}
btn_controller = {}
btn_play = {}
kb_controller_btn_kb = {}
kb_controller_btn_controller = {}
using_kb = true

UI_MENU = 0
UI_BTN = 1
UI_PROGRESS_BAR

ui_list = {}

menu_build = {}
menu_game = {}
menu_kb_controller = {}
menu_opening = nil

btn_selected = nil
btn_switched = false

BUILDING_RAIL = 0
BUILDING_RESTAURANT = 1
BUILDING_STATION = 2
BUILDING_REFILL = 3
BUILDING_FARM = 4
BUILDING_ARCADE = 5
MAP_EXPAND = 6

RAIL_COST = 1
RESTAURANT_COST = 8
STATION_COST = 6
REFILL_COST = 2
FARM_COST = 12
ARCADE_COST = 20
MAP_EXPAND_COST = 100
MAP_EXPAND_COST_1 = 400
expanded = 0

rail_inventory = 0
station_inventory = 0
refill_inventory = 0
farm_inventory = 0
arcade_inventory = 0

building_btn_list = {}
building_btn_pos_list = {}
building_btn_selected = nil

TAB_BTN_MARGIN_LEFT = 4
TAB_BTN_MARGIN_TOP = 4
TAB_BTN_SPACING_H = 12
TAB_BTN_SZ = { x: 32, y: 8 }
CARD_BTN_MARGIN_LEFT = TAB_BTN_MARGIN_LEFT + TAB_BTN_SZ.x + 4
CARD_BTN_MARGIN_TOP = TAB_BTN_MARGIN_TOP
CARD_BTN_SPACING_SZ = { x: 20, y: 20 + 7 }
CARD_BTN_SZ = { x: 16, y: 16 }

STATS_POS = { x: 2, y: 2 }

MAP_SZ_INIT = { x: 20, y: 12 }
MAP_SZ_1 = { x: 30, y: 18 }
MAP_SZ_MAX = { x: 40, y: 24 }
CAMERA_INIT_POS = { x: (-WINDOW_W+MAP_SZ_INIT.x*8)/2 + 8, y: (-WINDOW_H+MAP_SZ_INIT.y*8)/2 + 8 }
CAMERA_RANGE = { x: 70, y: 50 }

export BOOT = ->
	kb_controller_init()

export TIC = ->
	if at == AT_GAME
		game()
	elseif at == AT_START
		start()
	elseif at == AT_KB_CONTROLLER
		kb_controller()

	btn_switched = false
	t += 1

	if not btn(5)
		exit_menu_holding_5 = false
	if not btn(4)
		exit_menu_holding_4 = false

get_money_need = (wave) ->
	return math.floor((wave - 1) * 8 + (wave - 1)*(wave - 1)*1.5 + 8)

map_expand = ->
	if expanded == 0
		expanded = 1
		map_sz = MAP_SZ_1

	elseif expanded == 1
		expanded = 2
		map_sz = MAP_SZ_MAX

get_camera_limit = ->
	pos = { x: (-WINDOW_W+map_sz.x*8)/2 + 8, y: (-WINDOW_H+map_sz.y*8)/2 + 8 }
	return vecsub(pos, CAMERA_RANGE), vecadd(pos, CAMERA_RANGE)

btn_str = (btn_number) ->
	n = btn_number
	if n == 0
		return 'up'
	if n == 1
		return 'down'
	if n == 2
		return 'left'
	if n == 3
		return 'right'
	if n == 4
		if using_kb
			return 'Z'
		else
			return 'A'
	if n == 5
		if using_kb
			return 'X'
		else
			return 'B'
	if n == 6
		if using_kb
			return 'A'
		else
			return 'X'
	if n == 7
		if using_kb
			return 'S'
		else
			return 'Y'

game_init = ->
	map_sz = veccopy(MAP_SZ_INIT)
	camera.pos = veccopy(CAMERA_INIT_POS)

	close_all_menus()
	entity_list = {}
	ui_list = {}
	rail_grid = {}

	cursor.pos = vecnew(8, 8)

	dpad_mode = DPAD_CURSOR
	money_count = 10 + RESTAURANT_COST
	rail_inventory = 18
	station_inventory = 2
	refill_inventory = 0
	farm_inventory = 0
	arcade_inventory = 0

	expanded = 0

	time_remain = TIME_REMAIN_MAX
	money_fullfilled = 0
	wave = 1

	show_goal_text = 12 * 60

	create_menu_build()
	create_menu_game()

	for y = 1, MAP_SZ_MAX.y
		table.insert(rail_grid, {})
		for x = 1, MAP_SZ_MAX.x
			table.insert(rail_grid[y], -1)

	init_buildings()

init_buildings = ->
	for i = 2, 19
		rail_new(vecnew(i*8, 6*8))

	station_new(vecnew(8, 6*8))
	station_new(vecnew(20*8, 6*8))
	restaurant_new(vecnew(13*8, 4*8))

start_init = ->
	map_sz = veccopy(MAP_SZ_INIT)
	camera.pos = veccopy(CAMERA_INIT_POS)

	close_all_menus()
	entity_list = {}
	ui_list = {}
	rail_grid = {}

	create_start_screen_menu()

	money_count = RESTAURANT_COST
	rail_inventory = 18
	station_inventory = 2
	refill_inventory = 0
	farm_inventory = 0
	arcade_inventory = 0

	for y = 1, MAP_SZ_MAX.y
		table.insert(rail_grid, {})
		for x = 1, MAP_SZ_MAX.x
			table.insert(rail_grid[y], -1)

	init_buildings()

kb_controller_init = ->
	close_all_menus()
	entity_list = {}
	ui_list = {}
	rail_grid = {}

	kb_controller_btn_kb = btn_new(vecnew(4, 14), vecnew(60, 8), -1, vecnew(0, 0), 'Keyboard', () ->
		using_kb = true
		kb_controller_btn_kb.highlight = true
		kb_controller_btn_controller.highlight = false
	)

	kb_controller_btn_controller = btn_new(vecnew(4, 26), vecnew(60, 8), -1, vecnew(0, 0), 'Controller', () ->
		using_kb = false
		kb_controller_btn_kb.highlight = false
		kb_controller_btn_controller.highlight = true
	)

	kb_controller_btn_confirm = btn_new(vecnew(4, 42), vecnew(60, 8), -1, vecnew(0, 0), 'Confirm', () ->
		start_init()
		at = AT_START
		exit_menu_holding_4 = true
	)

	kb_controller_btn_kb.highlight = true

	select_btn(kb_controller_btn_kb)

	btn_connect(kb_controller_btn_kb, kb_controller_btn_controller, DOWN)
	btn_connect(kb_controller_btn_controller, kb_controller_btn_confirm, DOWN)

game = ->
	show_goal_text -= 1
	time_remain -= 1
	if time_remain <= 0
		time_remain = TIME_REMAIN_MAX
		if money_fullfilled < get_money_need(wave)
			lose = true
			close_all_menus()
		else
			wave += 1
			money_fullfilled = 0

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

start = ->
	entity_list_update()
	ui_list_update()

	cls(13)
	bkg_draw()
	entity_list_draw()
	draw_list_draw()
	title_draw()
	ui_list_draw()

	x = WINDOW_W - 4
	y = WINDOW_H - 4 - 8
	help_text_draw_at(vecnew(x, y), btn_str(4)..': select')

create_start_screen_menu = ->
	btn_play = btn_new(vecnew(4, 34), vecnew(60, 8), -1, vecnew(0, 0), 'Play', () ->
		game_init()
		at = AT_GAME
		exit_menu_holding_4 = true
	)

	btn_kb_controller = btn_new(vecnew(4, 46), vecnew(60, 8), -1, vecnew(0, 0), 'Kb/Controller', () ->
		open_menu(menu_kb_controller)
	)

	select_btn(btn_play)
	btn_connect(btn_play, btn_kb_controller, DOWN)

	create_kb_controller_menu()

create_kb_controller_menu = ->
	menu_kb_controller = menu_new(nil, vecnew(0, 0))

	btn_kb = btn_new(vecnew(4, 14), vecnew(60, 8), -1, vecnew(0, 0), 'Keyboard', () ->
		using_kb = true
		btn_kb.highlight = true
		btn_controller.highlight = false
	)

	btn_controller = btn_new(vecnew(4, 26), vecnew(60, 8), -1, vecnew(0, 0), 'Controller', () ->
		using_kb = false
		btn_kb.highlight = false
		btn_controller.highlight = true
	)


	btn_back = btn_new(vecnew(4, 42), vecnew(60, 8), -1, vecnew(0, 0), 'Back', () ->
		close_all_menus()
		select_btn(btn_play)
		exit_menu_holding_4 = true
	)

	menu_add_ui(menu_kb_controller, btn_kb)
	menu_add_ui(menu_kb_controller, btn_controller)
	menu_add_ui(menu_kb_controller, btn_back)

	menu_kb_controller.no_menu_btn = btn_play
	if using_kb
		btn_kb.highlight = true
	else
		btn_controller.highlight = true

	btn_connect(btn_kb, btn_controller, DOWN)
	btn_connect(btn_controller, btn_back, DOWN)

kb_controller = ->
	ui_list_update()

	cls(13)
	ui_list_draw()

	print('Are you using keyboard or controller?', 4, 4, 12, false, 1, true)

	x = WINDOW_W - 4
	y = WINDOW_H - 4 - 8
	help_text_draw_at(vecnew(x, y), 'Keyboard Z or controller A to select')

title_draw = ->
	if menu_opening != nil
		return
	print('Cardboardtop Railway', 4, 4, 12, false, 2, true)
	print('System', 4, 18, 12, false, 2, true)

create_nav = (menu) ->
	y = TAB_BTN_MARGIN_TOP
	btn_back = btn_new(vecnew(TAB_BTN_MARGIN_LEFT, y), TAB_BTN_SZ, 16, vecnew(1, 1), 'Back', (btn) ->
		close_all_menus()
		exit_menu_holding_4 = true
	)
	y += TAB_BTN_SPACING_H
	btn_build = btn_new(vecnew(TAB_BTN_MARGIN_LEFT, y), TAB_BTN_SZ, 17, vecnew(1, 1), 'Build', (btn) ->
		open_menu(menu_build)
	)
	y += TAB_BTN_SPACING_H
	btn_game = btn_new(vecnew(TAB_BTN_MARGIN_LEFT, y), TAB_BTN_SZ, 18, vecnew(1, 1), 'Game', (btn) ->
		open_menu(menu_game)
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

	tape_w = 16
	tape_h = 16
	rect(draw_pos.x + (map_sz.x*8 - tape_w)/2, draw_pos.y, tape_w, map_sz.y*8, 3)
	rect(draw_pos.x, draw_pos.y + (map_sz.y*8 - tape_h)/2, map_sz.x*8, tape_h, 3)

	rect(draw_pos.x, draw_pos.y + map_sz.y * 8, map_sz.x * 8, 7 * 8, 2)

create_menu_build = ->
	menu_build = menu_new(nil, vecnew(0, WINDOW_H - 60))
	menu = menu_build

	x = CARD_BTN_MARGIN_LEFT
	y = CARD_BTN_MARGIN_TOP
	btn_rail = create_building_btn(x, y, 32, BUILDING_RAIL)
	select_building_btn(btn_rail)

	x += CARD_BTN_SPACING_SZ.x
	btn_restaurant = create_building_btn(x, y, 34, BUILDING_RESTAURANT)

	x += CARD_BTN_SPACING_SZ.x
	btn_station = create_building_btn(x, y, 36, BUILDING_STATION)

	x += CARD_BTN_SPACING_SZ.x
	btn_refill = create_building_btn(x, y, 38, BUILDING_REFILL)

	x = CARD_BTN_MARGIN_LEFT
	y += CARD_BTN_SPACING_SZ.y
	btn_farm = create_building_btn(x, y, 40, BUILDING_FARM)

	x += CARD_BTN_SPACING_SZ.x
	btn_arcade = create_building_btn(x, y, 72, BUILDING_ARCADE)

	x += CARD_BTN_SPACING_SZ.x
	btn_expand = create_building_btn(x, y, 70, MAP_EXPAND)

	building_btn_list = { btn_rail, btn_restaurant, btn_station, btn_refill, btn_farm, btn_arcade, btn_expand }
	building_btn_connect(4, 2)

	menu_add_ui(menu, btn_rail)
	menu_add_ui(menu, btn_restaurant)
	menu_add_ui(menu, btn_station)
	menu_add_ui(menu, btn_refill)
	menu_add_ui(menu, btn_farm)
	menu_add_ui(menu, btn_arcade)
	menu_add_ui(menu, btn_expand)

	nav_btn_list = create_nav(menu)
	nav_btn_list[2].highlight = true
	connect_to_nav(nav_btn_list, btn_farm)
	connect_to_nav(nav_btn_list, btn_rail)

create_building_btn = (x, y, spr_id, building_type_tag) ->
	btn = btn_new(vecnew(x, y), CARD_BTN_SZ, spr_id, vecnew(2, 2), '', (btn) ->
		select_building_btn(btn)
	)
	btn.building_type_tag = building_type_tag
	table.insert(building_btn_pos_list, { pos: vecnew(x, y), building_type_tag: building_type_tag })
	return btn

create_menu_game = ->
	menu_game = menu_new(nil, vecnew(0, WINDOW_H - 60))

	x = CARD_BTN_MARGIN_LEFT
	y = CARD_BTN_MARGIN_TOP

	btn_restart = btn_new(vecnew(x, y), vecnew(30, 8), -1, vecnew(0, 0), 'Restart', (btn) ->
		game_init()
		exit_menu_holding_4 = true
	)
	x += 30 + 4
	btn_start_menu = btn_new(vecnew(x, y), vecnew(64, 8), -1, vecnew(0, 0), 'Back to main menu', (btn) ->
		start_init()
		at = AT_START
		exit_menu_holding_4 = true
	)

	menu_add_ui(menu_game, btn_restart)
	menu_add_ui(menu_game, btn_start_menu)

	nav_btn_list = create_nav(menu_game)
	nav_btn_list[3].highlight = true
	connect_to_nav(nav_btn_list, btn_restart)

	btn_connect(btn_restart, btn_start_menu, RIGHT)

building_btn_connect = (grid_w, grid_h) ->
	for x = 1, grid_w
		for y = 1, grid_h
			building_btn_connect_around(grid_w, grid_h, x, y)

building_btn_connect_around = (grid_w, grid_h, x, y) ->
	btn = get_building_btn_from_xy(grid_w, grid_h, x, y)
	if btn == nil
		return

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
	btn = nil
	if i + 1 <= #building_btn_list
		btn = building_btn_list[i + 1]
	return btn

game_controls_update = ->
	if lose
		if btnp(4)
			game_init()
			lose = false
			exit_menu_holding_4 = true
		return

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

	pos = vecdivdiv(cursor.pos, 8)

	cursor_sz = get_cursor_sz()

	if not exit_menu_holding_4
		if building_btn_selected.building_type_tag == BUILDING_RAIL
			if btn(4)
				rail_new(cursor.pos)

		if building_btn_selected.building_type_tag == BUILDING_STATION
			if btn(4)
				station_new(cursor.pos)

		if building_btn_selected.building_type_tag == BUILDING_RESTAURANT
			if btnp(4)
				restaurant_new(cursor.pos)

		if building_btn_selected.building_type_tag == BUILDING_REFILL
			if btnp(4)
				refill_new(cursor.pos)

		if building_btn_selected.building_type_tag == BUILDING_FARM
			if btnp(4)
				farm_new(cursor.pos)

		if building_btn_selected.building_type_tag == BUILDING_ARCADE
			if btnp(4)
				arcade_new(cursor.pos)

		if building_btn_selected.building_type_tag == MAP_EXPAND
			if btnp(4)
				if expanded == 0
					if money_count >= MAP_EXPAND_COST
						map_expand()
						money_count -= MAP_EXPAND_COST
				elseif expanded == 1
					if money_count >= MAP_EXPAND_COST_1
						map_expand()
						money_count -= MAP_EXPAND_COST_1
			
	if btn(5) and not exit_menu_holding_5
		if cursor_sz.x == 16
			for x = 0, 1
				for y = 0, 1
					pos2 = vecadd(pos, vecnew(x, y))
					building_rm(pos2)
		else
			building_rm(pos)

building_rm = (pos) ->
	rail_rm_xy(pos)
	station_rm_xy(pos)
	restaurant_rm_xy(pos)
	refill_rm_xy(pos)
	farm_rm_xy(pos)
	arcade_rm_xy(pos)
		
dpad_camera_update = ->
	if btn(0)
		camera.pos.y -= 1
	if btn(1)
		camera.pos.y += 1
	if btn(2)
		camera.pos.x -= 1
	if btn(3)
		camera.pos.x += 1
	
	top_left, bottom_right = get_camera_limit()
	if camera.pos.x < top_left.x
		camera.pos.x = top_left.x
	if camera.pos.x > bottom_right.x
		camera.pos.x = bottom_right.x
	if camera.pos.y < top_left.y
		camera.pos.y = top_left.y
	if camera.pos.y > bottom_right.y
		camera.pos.y = bottom_right.y

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
	cursor_sz = get_cursor_sz()
	if next_pos.x < 8 or next_pos.x - 8 + cursor_sz.x > map_sz.x*8
		move.x = 0

	if next_pos.y < 8 or next_pos.y - 8 + cursor_sz.y > map_sz.y*8
		move.y = 0

	cursor.pos = vecadd(cursor.pos, move)
		
game_controls_draw = ->
	if lose
		pos = vecnew(90, 60)
		print('GAME LOSE', pos.x, pos.y, 12, false, 1, true)
		print('Press '..btn_str(4)..' to restart', pos.x, pos.y + 8, 12, false, 1, true)
		return

	cursor_draw()

game_ui_draw = ->
	if show_goal_text > 0 and dpad_mode == DPAD_CURSOR
		print('^', 4, 36, 12, false, 1, true)
		print('Get enough money', 4, 44, 12, false, 1, true)
		print('Before time run out', 4, 52, 12, false, 1, true)

	if dpad_mode == DPAD_CURSOR
		spr(65, STATS_POS.x + 2, STATS_POS.y + 2, 0, 1, 0, 0, 1, 1)
		print(money_count, STATS_POS.x + 8, STATS_POS.y + 1, 12, false, 1, true)

	draw_goals(vecnew(STATS_POS.x + 2, STATS_POS.y + 10))

	bottom_left_card_draw()
	help_text_draw()
	camera_arrows_draw()

draw_goals = (pos) ->
	if dpad_mode != DPAD_CURSOR
		return

	print('wave '..wave, pos.x, pos.y, 12, false, 1, true)
	print('goal: '..money_fullfilled..'/'..get_money_need(wave), pos.x, pos.y + 8, 12, false, 1, true)
	rect(pos.x, pos.y + 18, 30, 2, 14)
	bar_w = 30 * (time_remain/TIME_REMAIN_MAX)
	rect(pos.x, pos.y + 18, bar_w, 2, 5)

camera_arrows_draw = ->
	if dpad_mode != DPAD_CAMERA
		return

	spr(81, WINDOW_W/2 - 4, 0, 0)
	spr(82, WINDOW_W/2 - 4, WINDOW_H - 8, 0)
	spr(83, 0, WINDOW_H/2 - 4, 0)
	spr(84, WINDOW_W - 8, WINDOW_H/2 - 4, 0)

help_text_draw = () ->
	x = WINDOW_W - 4
	y = 4

	if menu_opening == nil
		if dpad_mode == DPAD_CURSOR
			help_text_draw_at(vecnew(x, y), btn_str(7) .. ': menu')
			y += 8
			help_text_draw_at(vecnew(x, y), btn_str(4)..': place')
			y += 8
			help_text_draw_at(vecnew(x, y), btn_str(5)..': remove')
			y += 8
			help_text_draw_at(vecnew(x, y), btn_str(6)..': camera mode')
		else
			help_text_draw_at(vecnew(x, y), btn_str(6)..': cursor mode')

	else
		help_text_draw_at(vecnew(x, y), btn_str(4)..': select')
		y += 8
		help_text_draw_at(vecnew(x, y), btn_str(7)..'/'.. btn_str(5) ..': exit_menu')

help_text_draw_at = (pos, txt) ->
	draw_w = print(txt, 0, -100, 12, false, 1, true)
	print(txt, pos.x - draw_w, pos.y, 12, false, 1, true)

bottom_left_card_draw = ->
	if building_btn_selected == nil
		return

	if dpad_mode == DPAD_CAMERA
		return

	building_draw_pos = vecnew(2, WINDOW_H - CARD_BTN_SZ.y - 2)
	building_spr_id = 0
	building_cost = 0
	building_inventory = 0
	if building_btn_selected.building_type_tag == BUILDING_RAIL
		building_spr_id = 32
		building_cost = RAIL_COST
		building_inventory = rail_inventory
	if building_btn_selected.building_type_tag == BUILDING_RESTAURANT
		building_spr_id = 34
		building_cost = RESTAURANT_COST
		building_inventory = -1
	if building_btn_selected.building_type_tag == BUILDING_STATION
		building_spr_id = 36
		building_cost = STATION_COST
		building_inventory = station_inventory
	if building_btn_selected.building_type_tag == BUILDING_REFILL
		building_spr_id = 38
		building_cost = REFILL_COST
		building_inventory = refill_inventory
	if building_btn_selected.building_type_tag == BUILDING_FARM
		building_spr_id = 40
		building_cost = FARM_COST
		building_inventory = farm_inventory
	if building_btn_selected.building_type_tag == BUILDING_ARCADE
		building_spr_id = 72
		building_cost = ARCADE_COST
		building_inventory = arcade_inventory
	if building_btn_selected.building_type_tag == MAP_EXPAND
		building_spr_id = 70
		if expanded == 0
			building_cost = MAP_EXPAND_COST
		elseif expanded == 1
			building_cost = MAP_EXPAND_COST_1
		else
			building_cost = -1
		building_inventory = -1
	rect(building_draw_pos.x, building_draw_pos.y, CARD_BTN_SZ.x, CARD_BTN_SZ.y, 12)
	spr(building_spr_id, building_draw_pos.x, building_draw_pos.y, 0, 1, 0, 0, 2, 2)

	if building_inventory == -1
		cost_str = ''
		if building_cost == -1
			cost_str = 'map size maxed'
		else
			cost_str = 'cost: ' .. building_cost
		print(cost_str, building_draw_pos.x + CARD_BTN_SZ.x + 2, building_draw_pos.y + 10, 12, false, 1, true)
	else
		cost_str = 'cost: ' .. building_cost
		print(cost_str, building_draw_pos.x + CARD_BTN_SZ.x + 2, building_draw_pos.y + 3, 12, false, 1, true)
		iv_str = 'inventory: ' .. building_inventory
		print(iv_str, building_draw_pos.x + CARD_BTN_SZ.x + 2, building_draw_pos.y + 10, 12, false, 1, true)

cursor_draw = ->
	if dpad_mode != DPAD_CURSOR
		return

	cursor_sz = get_cursor_sz()

	draw_pos = get_draw_pos(cursor.pos)
	top_left = vecnew(draw_pos.x, draw_pos.y)
	top_right = vecnew(draw_pos.x + cursor_sz.x - 1, draw_pos.y)
	bottom_right = vecnew(draw_pos.x + cursor_sz.x - 1, draw_pos.y + cursor_sz.y - 1)
	bottom_left = vecnew(draw_pos.x, draw_pos.y + cursor_sz.y - 1)

	line(top_left.x, top_left.y, top_right.x, top_right.y, 12)
	line(top_right.x, top_right.y, bottom_right.x, bottom_right.y, 12)
	line(bottom_right.x, bottom_right.y, bottom_left.x, bottom_left.y, 12)
	line(bottom_left.x, bottom_left.y, top_left.x, top_left.y, 12)

get_cursor_sz = ->
	if building_btn_selected.building_type_tag == BUILDING_RESTAURANT
		return vecnew(16, 16)
	if building_btn_selected.building_type_tag == BUILDING_FARM
		return vecnew(16, 16)
	return vecnew(8, 8)

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
		if v == nil
			break
		v.update(i, v)

ui_list_draw = ->
	for i, v in ipairs(ui_list)
		v.draw(v)

open_menu = (menu) ->
	menu_opening = menu
	btn_selected = menu.first_btn
	exit_menu_holding_4 = true

close_all_menus = () ->
	menu_opening = nil
	btn_selected = nil

menu_new = (up_menu, pos) ->
	menu = ui_new(UI_MENU, menu_update, menu_draw)
	menu.up_menu = up_menu
	menu.sub_ui_list = {}
	menu.pos = veccopy(pos)
	menu.first_btn = nil
	menu.no_menu_btn = nil
	return menu

menu_update = (i, menu) ->
	if menu_opening != menu
		return

	if btnp(5)
		if menu.up_menu == nil
			exit_menu_holding_5 = true
			close_all_menus()
			if menu.no_menu_btn != nil
				select_btn(menu.no_menu_btn)
		else
			open_menu(menu.up_menu)

menu_draw = (menu) ->
	if menu_opening != menu
		return

	if menu == menu_build
		rect(menu.pos.x, menu.pos.y, WINDOW_W, WINDOW_H, 14)
		draw_desc(vecnew(menu.pos.x + 128, menu.pos.y + 4))
		draw_building_costs()

	if menu == menu_game
		rect(menu.pos.x, menu.pos.y, WINDOW_W, WINDOW_H, 14)

	if menu == menu_kb_controller
		print('Are you using keyboard or controller?', 4, 4, 12, false, 1, true)

draw_desc = (pos) ->
	if btn_selected.building_type_tag == nil
		return

	if btn_selected.building_type_tag == BUILDING_RAIL
		print('RAIL', pos.x, pos.y, 12, false, 1, true)
		print('Rail', pos.x, pos.y + 9, 12, false, 1, true)

	if btn_selected.building_type_tag == BUILDING_RESTAURANT
		print('RESTAURANT', pos.x, pos.y, 12, false, 1, true)
		print('When a train go near a', pos.x, pos.y + 9, 12, false, 1, true)
		print('restaurant, money is', pos.x, pos.y + 9 + 7, 12, false, 1, true)
		print('collected', pos.x, pos.y + 9 + 7*2, 12, false, 1, true)
		print('Refill using Refill', pos.x, pos.y + 9 + 7*3 + 2, 12, false, 1, true)
		print('Removed restaurant wont go', pos.x, pos.y + 9 + 7*4 + 2*2, 12, false, 1, true)
		print('back to inventory', pos.x, pos.y + 9 + 7*5 + 2*2, 12, false, 1, true)

	if btn_selected.building_type_tag == BUILDING_STATION
		print('STATION', pos.x, pos.y, 12, false, 1, true)
		print('Train go in and out of stations', pos.x, pos.y + 9, 12, false, 1, true)
		print('Can only be placed at left and', pos.x, pos.y + 11 + 7, 12, false, 1, true)
		print('right border of the map', pos.x, pos.y + 11 + 7*2, 12, false, 1, true)

	if btn_selected.building_type_tag == BUILDING_REFILL
		print('REFILL', pos.x, pos.y, 12, false, 1, true)
		print('Place next to restaurant to', pos.x, pos.y + 9, 12, false, 1, true)
		print('refill it', pos.x, pos.y + 9 + 7, 12, false, 1, true)

	if btn_selected.building_type_tag == BUILDING_FARM
		print('FARM', pos.x, pos.y, 12, false, 1, true)
		print('Create Refills', pos.x, pos.y + 9, 12, false, 1, true)
		print('Refills are placed nearby', pos.x, pos.y + 11 + 7, 12, false, 1, true)

	if btn_selected.building_type_tag == BUILDING_ARCADE
		print('ARCADE', pos.x, pos.y, 12, false, 1, true)
		print('Trains go near can have money', pos.x, pos.y + 9, 12, false, 1, true)
		print('collected by restaurant again', pos.x, pos.y + 9 + 7, 12, false, 1, true)
		print('Only work once for each train', pos.x, pos.y + 11 + 7*2, 12, false, 1, true)

	if btn_selected.building_type_tag == MAP_EXPAND
		print('MAP_EXPAND', pos.x, pos.y, 12, false, 1, true)
		print('Place anywhere to expand the', pos.x, pos.y + 9, 12, false, 1, true)
		print('map', pos.x, pos.y + 9 + 7, 12, false, 1, true)
		print('Can only be used 2 times', pos.x, pos.y + 11 + 7*2, 12, false, 1, true)

draw_building_costs = () ->
	for i, v in ipairs(building_btn_pos_list)
		if v.building_type_tag == BUILDING_RAIL
			draw_building_cost_under_btn(vecadd(v.pos, menu_build.pos), RAIL_COST, rail_inventory)

		if v.building_type_tag == BUILDING_RESTAURANT
			draw_building_cost_under_btn(vecadd(v.pos, menu_build.pos), RESTAURANT_COST, -1)

		if v.building_type_tag == BUILDING_STATION
			draw_building_cost_under_btn(vecadd(v.pos, menu_build.pos), STATION_COST, station_inventory)

		if v.building_type_tag == BUILDING_REFILL
			draw_building_cost_under_btn(vecadd(v.pos, menu_build.pos), REFILL_COST, refill_inventory)

		if v.building_type_tag == BUILDING_FARM
			draw_building_cost_under_btn(vecadd(v.pos, menu_build.pos), FARM_COST, farm_inventory)

		if v.building_type_tag == BUILDING_ARCADE
			draw_building_cost_under_btn(vecadd(v.pos, menu_build.pos), ARCADE_COST, arcade_inventory)

		if v.building_type_tag == MAP_EXPAND
			if expanded == 0
				draw_building_cost_under_btn(vecadd(v.pos, menu_build.pos), MAP_EXPAND_COST, -1)
			elseif expanded == 1
				draw_building_cost_under_btn(vecadd(v.pos, menu_build.pos), MAP_EXPAND_COST_1, -1)
			else
				draw_building_cost_under_btn(vecadd(v.pos, menu_build.pos), -1, -1)
			
draw_building_cost_under_btn = (pos, cost, inventory) ->
	if cost == -1
		print('max', pos.x, pos.y + CARD_BTN_SZ.y + 2, 12, false, 1, true)
	else
		print(cost, pos.x, pos.y + CARD_BTN_SZ.y + 2, 12, false, 1, true)

	if inventory != -1
		print(inventory, pos.x + 9, pos.y + CARD_BTN_SZ.y + 2, 4, false, 1, true)

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

	cursor_sz = get_cursor_sz()
	if cursor.pos.x - 8 + cursor_sz.x > map_sz.x*8
		cursor.pos.x -= 8

	if cursor.pos.y - 8 + cursor_sz.y > map_sz.y*8
		cursor.pos.y -= 8

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

	if btnp(4) and not exit_menu_holding_4
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
	shading_color = 15
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

--progress_bar_new = (pos, w, init_filled, color) ->
--	progress_bar = ui_new(UI_PROGRESS_BAR, progress_bar_update, progress_bar_draw)
--	progress_bar.pos = veccopy(pos)
--	progress_bar.w = w
--	progress_bar.filled = init_filled
--	progress_bar.color = color
--	return progress_bar
--
--progress_bar_update = (i, progress_bar) ->
--	if progress_bar.filled < 0
--		progress_bar.filled = 0
--	if progress_bar.filled > 1
--		progress_bar.filled = 1
--
--progress_bar_draw = (progress_bar) ->
--	rect(progress_bar.pos.x, progress_bar.pos.y, progress_bar.w, 2, 14)
--	
--	draw_w = progress_bar.filled * progress_bar.w
--	rect(progress_bar.pos.x, progress_bar.pos.y, draw_w, 2, progress_bar.color)

can_place = (grid_pos, sz) ->
	if grid_pos.x < 1 or grid_pos.y < 1 or grid_pos.x > map_sz.x or grid_pos.y > map_sz.y
		return false

	if rail_grid[grid_pos.y][grid_pos.x] != -1
		return false
	
	for i, v in ipairs(entity_list)
		if not is_in_list(BUILDING_ENTITY_LIST, v.type_tag)
			continue
		pos = vecmul(grid_pos, 8)
		if rect_collide(v.pos, v.sz, pos, sz)
			return false

	return true

rail_new = (pos) ->
	if money_count < RAIL_COST and rail_inventory == 0
		return

	grid_pos = vecdivdiv(pos, 8)
	if not can_place(grid_pos, vecnew(8, 8))
		return

	if rail_inventory != 0
		rail_inventory -= 1
	else
		money_count -= RAIL_COST

	rail = entity_new(ENTITY_RAIL, pos, vecnew(8, 8), rail_update, rail_draw)
	rail.rail_type_tag = RAIL_HORIZONTAL
	rail.rm_next_frame = false

	rail_grid[grid_pos.y][grid_pos.x] = rail
	set_rail_type_tag(grid_pos.x, grid_pos.y)
	update_surround_rail_type_tag(grid_pos.x, grid_pos.y)

	train_check_path_all()
	station_check_path_all()

	return rail

rail_rm_xy = (grid_pos) ->
	x = grid_pos.x
	y = grid_pos.y
	if rail_grid[y][x] != -1
		rail_grid[y][x].rm_next_frame = true
		rail_grid[y][x] = -1
		train_check_path_all()
		station_check_path_all()
		rail_inventory += 1
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

	draw(spr_id, draw_pos.x, draw_pos.y, 0, 1, flip, 0, 1, 1, rail.pos, -1)

station_new = (pos) ->
	if money_count < STATION_COST and station_inventory == 0
		return

	grid_pos = vecdivdiv(pos, 8)
	if not can_place(grid_pos, vecnew(8, 8))
		return

	if pos.x != 8 and pos.x != map_sz.x * 8
		return

	if station_inventory != 0
		station_inventory -= 1
	else
		money_count -= STATION_COST

	station = entity_new(ENTITY_STATION, pos, vecnew(8, 8), station_update, station_draw)
	station.rm_next_frame = false
	station.have_path = false
	station.created_at = t

	train_check_path_all()
	station_check_path_all()

	return station

station_rm_xy = (grid_pos) ->
	for i, v in ipairs(entity_list)
		if v.type_tag != ENTITY_STATION
			continue
		v_grid_pos = vecdivdiv(v.pos, 8)
		if not vecequals(grid_pos, v_grid_pos)
			continue
		v.rm_next_frame = true
		train_check_path_all()
		station_check_path_all()
		station_inventory += 1
		return

station_update = (i, station) ->
	station_create_train(station)

	if station.rm_next_frame
		table.remove(entity_list, i)

station_create_train = (station) ->
	if not station.have_path
		return

	if (t-station.created_at-(60*2)) % (60*12) != 0
		return

	grid_pos = vecdivdiv(station.pos, 8)
	x = grid_pos.x
	y = grid_pos.y
	right = false
	up = false
	down = false

	if x + 1 <= map_sz.x
		if rail_grid[y][x+1] != -1
			right = true
	if y - 1 >= 1
		if rail_grid[y-1][x] != -1
			up = true
	if y + 1 <= map_sz.y
		if rail_grid[y+1][x] != -1
			down = true

	total = 0
	if right
		total += 1
	if up
		total += 1
	if down
		total += 1
	choose_right = false
	choose_up = false
	choose_down = false
	if total == 1
		if right
			choose_right = true
		if up
			choose_up = true
		if down
			choose_down = true
	if total == 2
		if right and up
			if dice(1, 2)
				choose_right = true
			else
				choose_up = true
		if right and down
			if dice(1, 2)
				choose_right = true
			else
				choose_down = true
		if up and down
			if dice(1, 2)
				choose_up = true
			else
				choose_down = true
	if total == 3
		rnd = rndi(1, 3)
		if rnd == 1
			choose_right = true
		elseif rnd == 2
			choose_up = true
		elseif rnd == 3
			choose_down = true
	
	if choose_right
		train_new(vecnew(station.pos.x + 8, station.pos.y))
	elseif choose_up
		train_new(vecnew(station.pos.x, station.pos.y - 8))
	elseif choose_down
		train_new(vecnew(station.pos.x, station.pos.y + 8))

station_draw = (station) ->
	draw_pos = get_draw_pos(station.pos)
	if station.pos.x == 8 and not station.have_path
		draw(64, draw_pos.x + 3, draw_pos.y - 14, 0, 1, 0, 0, 1, 2, vecnew(0, 0), 10)
	draw(9, draw_pos.x, draw_pos.y - 8, 0, 1, 0, 0, 1, 2, station.pos, 0)

station_check_path_all = ->
	for i, v in ipairs(entity_list)
		if v.type_tag != ENTITY_STATION
			continue
		station_check_path(v)

station_check_path = (station) ->
	path = train_get_path(station)
	if #path <= 0
		station.have_path = false
	else
		station.have_path = true

train_new = (pos) ->
	train = entity_new(ENTITY_TRAIN, pos, vecnew(8, 8), train_update, train_draw)
	train.path = train_get_path(train)
	train.arcaded = false
	train.served = false
	return train

train_update = (i, train) ->
	train_move(train)
	train_check_rm(i, train)

train_move = (train) ->
	if #train.path <= 0
		return

	grid_pos = train.path[#train.path]
	pos = vecmul(grid_pos, 8)
	diff = vecsub(pos, train.pos)
	move = vecnew(0, 0)
	if diff.x > 0
		move.x = 0.5
	elseif diff.x < 0
		move.x = -0.5
	elseif diff.y > 0
		move.y = 0.5
	elseif diff.y < 0
		move.y = -0.5

	if veclengthsqr(diff) < 0.1
		table.remove(train.path, #train.path)
		
	train.pos = vecadd(train.pos, move)

train_get_path = (train) ->
	grid_pos = vecdivdiv(train.pos, 8)
	path = {}
	grid = {}
	for iy = 1, map_sz.y
		table.insert(grid, {})
		for ix = 1, map_sz.x
			table.insert(grid[iy], false)
	
	recursion_train_get_path(path, grid, grid_pos)
	return path
	
recursion_train_get_path = (path, grid, xy) ->
	grid[xy.y][xy.x] = true

	dir_list = {
		vecnew(-1, 0),
		vecnew(1, 0),
		vecnew(0, -1),
		vecnew(0, 1),
	}
	dir_list = list_shuffle(dir_list)

	for i, v in ipairs(dir_list)
		next_pos = vecadd(xy, v)

		if next_pos.x < 1 or next_pos.y < 1 or next_pos.x > map_sz.x or next_pos.y > map_sz.y
			continue

		if grid[next_pos.y][next_pos.x] == true
			continue

		if next_pos.x == MAP_SZ_INIT.x or next_pos.x == MAP_SZ_1.x or next_pos.x == MAP_SZ_MAX.x
			for j, v2 in ipairs(entity_list)
				if v2.type_tag != ENTITY_STATION
					continue
				if v2.rm_next_frame
					continue
				if not vecequals(next_pos, vecdivdiv(v2.pos, 8))
					continue
				table.insert(path, next_pos)
				return true

		if rail_grid[next_pos.y][next_pos.x] == -1
			continue

		if rail_grid[next_pos.y][next_pos.x].rm_next_frame
			continue
		
		if recursion_train_get_path(path, grid, next_pos) == true
			table.insert(path, next_pos)
			return true

	return false

train_check_rm = (i, train) ->
	grid_pos = vecdivdiv(train.pos, 8)

	if rail_grid[grid_pos.y][grid_pos.x] == -1
		table.remove(entity_list, i)
		return

	for j, v in ipairs(entity_list)
		if v.type_tag != ENTITY_STATION
			continue
		if v.pos.x == 8
			continue
		if not rect_collide(train.pos, train.sz, v.pos, v.sz)
			continue
		table.remove(entity_list, i)
		return

train_draw = (train) ->
	draw_pos = get_draw_pos(train.pos)

	if #train.path == 0
		draw(64, draw_pos.x + 3, draw_pos.y - 16, 0, 1, 0, 0, 1, 2, vecnew(0, 0), 10)

	if #train.path != 0 and not train.served
		draw(65, draw_pos.x + 2, draw_pos.y - 10, 0, 1, 0, 0, 1, 1, vecnew(0, 0), 10)

	draw(10, draw_pos.x, draw_pos.y - 10, 0, 1, 0, 0, 1, 2, vecadd(train.pos, vecnew(0, 0)), 0)

train_check_path_all = ->
	for i, v in ipairs(entity_list)
		if v.type_tag != ENTITY_TRAIN
			continue
		v.path = train_get_path(v)

RESTAURANT_SERVE_COUNT_MAX = 16
SHOW_MONEY_MARK_FOR = 60
restaurant_new = (pos) ->
	if money_count < RESTAURANT_COST
		return

	grid_pos = vecdivdiv(pos, 8)
	if not can_place(grid_pos, vecnew(16, 16))
		return

	money_count -= RESTAURANT_COST

	restaurant = entity_new(ENTITY_RESTAURANT, pos, vecnew(16, 16), restaurant_update, restaurant_draw)
	restaurant.rm_next_frame = false
	restaurant.serve_count = RESTAURANT_SERVE_COUNT_MAX
	restaurant.show_money_mark = 0

	return restaurant

restaurant_rm_xy = (grid_pos) ->
	for i, v in ipairs(entity_list)
		if v.type_tag != ENTITY_RESTAURANT
			continue
		if not rect_collide(vecmul(grid_pos, 8), vecnew(8, 8), v.pos, v.sz)
			continue
		v.rm_next_frame = true
		return

restaurant_update = (i, restaurant) ->
	restaurant_serve(restaurant)
	restaurant_refill(restaurant)

	restaurant.show_money_mark -= 1

	if restaurant.rm_next_frame
		table.remove(entity_list, i)

restaurant_serve = (restaurant) ->
	if restaurant.serve_count == 0
		return

	for j, v in ipairs(entity_list)
		if v.type_tag != ENTITY_TRAIN
			continue
		if not rect_collide(vecadd(restaurant.pos, vecnew(-8, -8)), vecnew(32, 32), v.pos, v.sz)
			continue
		if v.served
			continue
		v.served = true
		money_count += 1
		money_fullfilled += 1
		restaurant.show_money_mark = SHOW_MONEY_MARK_FOR
		restaurant.serve_count -= 1

restaurant_refill = (restaurant) ->
	if restaurant.serve_count > 0
		return

	for i, v in ipairs(entity_list)
		if v.type_tag != ENTITY_REFILL
			continue
		if v.rm_next_frame
			continue
		if not rect_collide(vecadd(restaurant.pos, vecnew(-8, -8)), vecnew(32, 32), v.pos, v.sz)
			continue
		v.rm_next_frame = true
		restaurant.serve_count = RESTAURANT_SERVE_COUNT_MAX
		return

restaurant_draw = (restaurant) ->
	draw_pos = get_draw_pos(restaurant.pos)
	draw(11, draw_pos.x, draw_pos.y - 8, 0, 1, 0, 0, 2, 3, vecadd(restaurant.pos, vecnew(8, 8)), 0)

	bar_w = 16
	draw_rect(draw_pos.x, draw_pos.y - 4, bar_w, 2, 14, vecnew(0, 0), 11)
	bar_filled_w = bar_w * (restaurant.serve_count / RESTAURANT_SERVE_COUNT_MAX)
	draw_rect(draw_pos.x, draw_pos.y - 4, bar_filled_w, 2, 6, vecnew(0, 0), 12)

	if restaurant.show_money_mark > 0
		draw_text('+1', draw_pos.x + 4, draw_pos.y - 12, 5, false, 1, true, vecnew(0, 0), 10)

refill_new = (pos) ->
	if money_count < REFILL_COST and refill_inventory == 0
		return

	grid_pos = vecdivdiv(pos, 8)
	if not can_place(grid_pos, vecnew(8, 8))
		return

	if refill_inventory != 0
		refill_inventory -= 1
	else
		money_count -= REFILL_COST

	refill = entity_new(ENTITY_REFILL, pos, vecnew(8, 8), refill_update, refill_draw)
	refill.rm_next_frame = false
	return refill

refill_rm_xy = (grid_pos) ->
	for i, v in ipairs(entity_list)
		if v.type_tag != ENTITY_REFILL
			continue
		if not vecequals(grid_pos, vecdivdiv(v.pos, 8))
			continue
		v.rm_next_frame = true
		refill_inventory += 1
		return

refill_update = (i, refill) ->
	if refill.rm_next_frame
		table.remove(entity_list, i)

refill_draw = (refill) ->
	draw_pos = get_draw_pos(refill.pos)
	draw(13, draw_pos.x, draw_pos.y - 8, 0, 1, 0, 0, 1, 2, refill.pos, 0)

FARM_CREATE_REFILL_COOLDOWN = 32 * 60
farm_new = (pos) ->
	if money_count < FARM_COST and farm_inventory == 0
		return

	grid_pos = vecdivdiv(pos, 8)
	if not can_place(grid_pos, vecnew(16, 16))
		return

	if farm_inventory != 0
		farm_inventory -= 1
	else
		money_count -= FARM_COST

	farm = entity_new(ENTITY_FARM, pos, vecnew(16, 16), farm_update, farm_draw)
	farm.rm_next_frame = false
	farm.until_refill = FARM_CREATE_REFILL_COOLDOWN
	return farm

farm_rm_xy = (grid_pos) ->
	for i, v in ipairs(entity_list)
		if v.type_tag != ENTITY_FARM
			continue
		if not rect_collide(vecmul(grid_pos, 8), vecnew(8, 8), v.pos, v.sz)
			continue
		if v.rm_next_frame == true
			continue

		v.rm_next_frame = true
		farm_inventory += 1
		return

farm_update = (i, farm) ->
	farm.until_refill -= 1
	if farm.until_refill <= 0
		farm.until_refill = FARM_CREATE_REFILL_COOLDOWN
		farm_create_refill(farm)

	if farm.rm_next_frame
		table.remove(entity_list, i)

farm_create_refill = (farm) ->
	farm_grid_pos = vecdivdiv(farm.pos, 8)
	pos_list = {}

	for x = -1, 2
		for y = -1, 2
			if not can_place(vecadd(farm_grid_pos, vecnew(x, y)), vecnew(8, 8))
				continue
			table.insert(pos_list, vecnew(x, y))

	if #pos_list == 0
		return

	i = rndi(1, #pos_list)
	refill_new(vecadd(farm.pos, vecmul(pos_list[i], 8)))
	money_count += 2

farm_draw = (farm) ->
	draw_pos = get_draw_pos(farm.pos)
	draw(45, draw_pos.x, draw_pos.y - 8, 0, 1, 0, 0, 2, 3, vecadd(farm.pos, vecnew(8, 8)), 0)

	bar_w = 16
	draw_rect(draw_pos.x, draw_pos.y - 4, bar_w, 2, 14, vecnew(0, 0), 11)
	bar_filled_w = (1 - (farm.until_refill / FARM_CREATE_REFILL_COOLDOWN)) * bar_w
	draw_rect(draw_pos.x, draw_pos.y - 4, bar_filled_w, 2, 6, vecnew(0, 0), 12)

arcade_new = (pos) ->
	if money_count < ARCADE_COST and arcade_inventory == 0
		return

	grid_pos = vecdivdiv(pos, 8)
	if not can_place(grid_pos, vecnew(8, 8))
		return

	if arcade_inventory != 0
		arcade_inventory -= 1
	else
		money_count -= ARCADE_COST

	arcade = entity_new(ENTITY_ARCADE, pos, vecnew(8, 8), arcade_update, arcade_draw)
	arcade.rm_next_frame = false
	return arcade

arcade_rm_xy = (grid_pos) ->
	for i, v in ipairs(entity_list)
		if v.type_tag != ENTITY_ARCADE
			continue
		if not rect_collide(vecmul(grid_pos, 8), vecnew(8, 8), v.pos, v.sz)
			continue
		v.rm_next_frame = true
		arcade_inventory += 1
		return

arcade_update = (i, arcade) ->
	arcade_arcade(arcade)

	if arcade.rm_next_frame
		table.remove(entity_list, i)

arcade_arcade = (arcade) ->
	for i, v in ipairs(entity_list)
		if v.type_tag != ENTITY_TRAIN
			continue

		if not rect_collide(v.pos, v.sz, vecsub(arcade.pos, vecnew(8, 8)), vecnew(24, 24))
			continue

		if v.arcaded
			continue
		
		if not v.served
			continue

		v.arcaded = true
		v.served = false

arcade_draw = (arcade) ->
	draw_pos = get_draw_pos(arcade.pos)
	draw(58, draw_pos.x, draw_pos.y - 8, 0, 1, 0, 0, 1, 2, arcade.pos, 0)

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
		if v == nil
			break
		v.update(i, v)

entity_list_draw = () ->
	for i, v in ipairs(entity_list)
		v.draw(v)

DRAW_SPR = 0
DRAW_RECT = 1
DRAW_TEXT = 2
draw = (spr_id, x, y, color_key, scale, flip, rotate, w, h, center_pos, z_index) ->
	d = {
		type_tag: DRAW_SPR,
		spr_id: spr_id,
		x: x,
		y: y,
		color_key: color_key,
		scale: scale,
		flip: flip,
		rotate: rotate,
		w: w,
		h: h,
		center_pos: veccopy(center_pos)
		z_index: z_index
	}

	table.insert(draw_list, d)

draw_rect = (x, y, w, h, color, center_pos, z_index) ->
	d = {
		type_tag: DRAW_RECT,
		x: x,
		y: y,
		w: w,
		h: h,
		color: color,
		center_pos: veccopy(center_pos),
		z_index: z_index,
	}
	table.insert(draw_list, d)

draw_text = (text, x, y, color, fixed, scale, small_font, center_pos, z_index) ->
	d = {
		type_tag: DRAW_TEXT,
		text: text,
		x: x,
		y: y,
		color: color,
		fixed: fixed,
		scale: scale,
		small_font: small_font,
		center_pos: center_pos,
		z_index: z_index,
	}
	table.insert(draw_list, d)

draw_list_draw = ->
	table.sort(draw_list, (a, b) ->
		if a.z_index != b.z_index
			return a.z_index < b.z_index

		return a.center_pos.y < b.center_pos.y
	)

	for i, v in ipairs(draw_list)
		if v.type_tag == DRAW_SPR
			spr(v.spr_id, v.x, v.y, v.color_key, v.scale, v.flip, v.rotate, v.w, v.h)
		if v.type_tag == DRAW_RECT
			rect(v.x, v.y, v.w, v.h, v.color)
		if v.type_tag == DRAW_TEXT
			print(v.text, v.x, v.y, v.color, v.fixed, v.scale, v.small_font)

	draw_list = {}

vecequals = (veca, vecb) ->
	return veca.x == vecb.x and veca.y == vecb.y

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

veclength = (vec) ->
	return math.sqrt(vec.x*vec.x + vec.y*vec.y)

veclengthsqr = (vec) ->
	return vec.x*vec.x + vec.y*vec.y

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

rndf = (a, b) ->
	return math.random() * (b - a) + a

rndi = (a, b) ->
	return math.random(a, b)

dice = (a, b) ->
	rnd = rndi(1, b)
	return rnd >= 1 and rnd <= a

list_shuffle = (list) ->
	result = {}
	list_sz = #list
	for i = 1, list_sz
		rnd = rndi(1, list_sz - i + 1)
		table.insert(result, list[rnd])
		table.remove(list, rnd)
	return result

is_in_list = (list, item) ->
	for i, v in ipairs(list)
		if v == item
			return true
	return false

find_in_list = (list, item) ->
	for i, v in ipairs(list)
		if v == item
			return i
	return -1

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
-- 058:00000000000000000000000000000000000000000000000000000000cccccccc
-- 061:de666666d0066660d0003300d0003300d0000000d0000006d0333306d0344306
-- 062:eeeeeeed0000000d0000000d0000000d0000000d666666666666666666666666
-- 064:2200000022000000220000002200000022000000220000000000000000000000
-- 065:6666000065560000666600000000000000000000000000000000000000000000
-- 070:00000000000000000000000d000000dd0000000000000033000d003300dd0033
-- 071:0000000000000000d0000000dd00000000000000330000003300d0003300dd00
-- 072:0000000000000000000000000000444400004ccc00004caa00004caa00004ccc
-- 073:00000000000000000000000044440000ccc4000024c4000055c40000ccc40000
-- 074:caa2244ccaa2244ccaa5555ccaa5555cccccccccdddddddddddddddddddddddd
-- 077:d0333306d0222206d0233206d0222207d0000007d0000007ddddddd7eeeeeee7
-- 078:6666666666666666666666667777777777777777777777777777777777777777
-- 080:2200000022000000000000000000000000000000000000000000000000000000
-- 081:0000000000000000000c000000ccc0000ccccc00000000000000000000000000
-- 082:0000000000000000000000000ccccc0000ccc000000c00000000000000000000
-- 083:000000000000c000000cc00000ccc000000cc0000000c0000000000000000000
-- 084:00000000000c0000000cc000000ccc00000cc000000c00000000000000000000
-- 086:00dd0022000d00220000000000000000000000dd0000000d0000000000000000
-- 087:2200dd002200d0000000000000000000dd000000d00000000000000000000000
-- 088:00004ddd00004ddd00004ddd0000444400000000000000000000000000000000
-- 089:ddd40000ddd40000ddd400004444000000000000000000000000000000000000
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

