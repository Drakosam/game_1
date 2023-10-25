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
		

func get_path_to_tile(start_tile, target_tile, agent_name):
	var path = [target_tile, start_tile]
	return {
		'target_name':agent_name,
		'path':path
	}
		

func _region_selected(hex_name):
	end_move_proces()
	emit_signal('selected_region_whos_picked', hex_name)
	
