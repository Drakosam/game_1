extends Node 

var tile_list = []
var rng = RandomNumberGenerator.new()

signal selected_region_whos_picked(hex_name)

func _ready():
	pass 


func register_tile(tile):
	tile_list.append(tile)
	tile.connect('picket_move',_region_selected)
	if not tile.agent_in_region:
		tile.visible = false


func update_agent_posytions(agent_posytions):
	print(agent_posytions)
	for tile in tile_list:
		if tile.name in agent_posytions:
			tile.agent_in_region = true
			if not tile.visible:
				tile.visible = true
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
	var path = []

	for i  in range(max_d-1):
		var step_pos = (end_tile.position/max_d) * (1 + i)

		for tile in tile_list:
			if tile.region_level == start_tile.region_level:
				var i_d = tile.get_distance_from_me(step_pos)
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


func  resolve_job_result(job_result):
	if 'EXPLORE' == job_result['job_type']:
		for item in job_result['results']:
			if item['name'] == 'new_region':
				_reveal_new_region(job_result['tile'])
			if item['name'] == 'new_resources':
				_reveal_new_resources(job_result['tile'])


func _reveal_new_resources(region_name):
	for tile in tile_list:
		if tile.name == region_name:
			rng.randomize()
			tile.resource == rng.randi_range(30, 60)
			break


func get_resource_from_region(region_name, value):
	for tile in tile_list:
		if tile.name == region_name:

			if value >= tile.resource:
				tile.resource -= value
				return 0

			else:

				var r_value = value - tile.resource
				tile.resource = 0
				return r_value

			break


func _reveal_new_region(start_tile):
	print('reveal_new_region')
	var target_tile = null
	for item in tile_list:
		if item.name == start_tile:
			target_tile = item
			break
	var region_to_reveal = []

	for tile in tile_list:
		if tile.region_level == target_tile.region_level:
			var i_d = round(target_tile.get_distance_from_me(tile.position))
			if 1 == i_d and not tile.visible:
				region_to_reveal.append(tile)

	if region_to_reveal.size()==1:
		region_to_reveal[0].visible = true

	if region_to_reveal.size()>1:
		rng.randomize()
		var dice = rng.randi_range(0,region_to_reveal.size()-1)
		region_to_reveal[dice].visible = true
