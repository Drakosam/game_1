extends Node2D

var tile_list = []

func _ready():
	pass 


func register_tile(tile):
	tile_list.append(tile)


func update_agent_posytions(agent_posytions):
	for tile in tile_list:
		if tile.name in agent_posytions:
			tile.agent_in_region = true
			print('agent in ', tile.name)
		else:
			tile.agent_in_region = false
