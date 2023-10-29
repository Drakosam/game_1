extends Node 

var tile_list = []

signal selected_region_whos_picked(hex_name)

func _ready():
	pass 


func register_tile(tile):
	tile_list.append(tile)
	tile.connect('picket_move',_region_selected)


func update_agent_posytions(agent_posytions):
	print(agent_posytions)
	for tile in tile_list:
		if tile.name in agent_posytions:
			tile.agent_in_region = true
			print('agent in ', tile.name)
		else:
			tile.agent_in_region = false


func start_move_proces():
	for tile in tile_list:
		tile.move_process = true


func end_move_proces():
	for tile in tile_list:
		tile.move_process = false


func _path_finder(start_tile, end_tile):
	var max_d =  round(start_tile.get_distance_from_me(end_tile.position))
	print(start_tile.position, end_tile.position)
	var path = []
	
	for i  in range(max_d-1):
		var step_pos = (end_tile.position/max_d) * (1 + i)
		for tile in tile_list:
			if tile.region_level == start_tile.region_level:
				var i_d = tile.get_distance_from_me(step_pos)
				print(i_d)
				if 1 > i_d :
					path.append(tile.name)
					break
	
	path.append(end_tile.name)
	return path


func get_path_to_tile(start_tile_name, target_tile_name, agent_name):
	var s_tile = null
	var e_tile = null
	
	for item in tile_list:
		if item.name == start_tile_name:
			s_tile = item
			break
	
	for item in tile_list:
		if item.name == target_tile_name:
			e_tile = item
			break
	
	return {
		'target_name':agent_name,
		'path':_path_finder(s_tile,e_tile)
	}
		

func _region_selected(hex_name):
	end_move_proces()
	emit_signal('selected_region_whos_picked', hex_name)
	
