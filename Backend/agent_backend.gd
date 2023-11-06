extends Node


var AgentClass = preload("res://Actors/agent.tscn")
var show_region_name = ''

signal update_agent_locations(agent_locations)
signal update_agents_in_region(agents_list)
signal chec_path_to_tile(start_tile, target_tile, agent_name)
signal job_done_result( job_result )
signal consume_food_event(consume_value, agent_name)


func _ready():
	pass 


func add_agent(agent_seed=null):
	if agent_seed == null:
		agent_seed = {}
	var new_agent = AgentClass.instantiate()
	
	new_agent.connect('move_to_new_region',new_location_for_agent)
	new_agent.connect('check_path_to_target_posytion',_chec_path_to_tile)
	new_agent.connect('job_done_result',_job_done_result)
	new_agent.connect('consume_food_event',_consume_food_event)
	new_agent.connect('im_dead',_agent_is_dead)
	
	add_child(new_agent)
	
	if 'location' in agent_seed:
		new_agent.tile_posytion = agent_seed['location']
	
	if 'name' in agent_seed:
		new_agent.name = agent_seed['name']
	else:
		new_agent.name = 'Agent_'+str(new_agent.get_instance_id())
	
	new_location_for_agent()


func new_location_for_agent():
	update_agent_posytion()
	refrsh_pick_agent_list_for_region()


func update_agent_posytion():
	var agent_locations = []
	for agent in get_children():
		agent_locations.append(agent.tile_posytion)
	
	emit_signal('update_agent_locations', agent_locations)


func pick_agent_list_for_region(region_name = ''):
	if show_region_name != region_name and region_name:
		show_region_name = region_name
		refrsh_pick_agent_list_for_region()


func refrsh_pick_agent_list_for_region():
	var agents_in_location = []
	for agent in get_children():
		if agent.tile_posytion == show_region_name:
			agents_in_location.append(agent)
	
	emit_signal("update_agents_in_region",agents_in_location)


func _chec_path_to_tile(start_tile, target_tile, agent_name):
	emit_signal('chec_path_to_tile', start_tile, target_tile, agent_name)


func set_tile_path(agent_name, path):
	print('set tile path recive data :: agent name -> ',agent_name, ' path -> ',path)
	for child in get_children():
		child.set_target_region_path(agent_name, path)
	

func act():
	for child in get_children():
		child.act()


func _job_done_result(job_result):
	print(job_result)
	if job_result['job_type'] == 'RECRUITING':
		for result in job_result['results']:
			if 'status' in result and result['status']=='SUCCESS':
				print('add new agent')
				add_agent({'location':job_result['tile']})
	else:
		emit_signal('job_done_result',job_result)


func resolve_consume_event_for_agent(food_dif,agent_name):
	for child in get_children():
		child.consume_result(food_dif, agent_name)


func _consume_food_event(consume_value, agent_name):
	emit_signal('consume_food_event',consume_value, agent_name)
	

func _agent_is_dead(agent_name):
	print('agent :: ',agent_name,' is dead')
	for child in get_children():
		if child.name == agent_name:
			remove_child(child)
			new_location_for_agent()
			child.disconnect('move_to_new_region',new_location_for_agent)
			child.disconnect('check_path_to_target_posytion',_chec_path_to_tile)
			child.disconnect('job_done_result',_job_done_result)
			child.disconnect('consume_food_event',_consume_food_event)
			child.disconnect('im_dead',_agent_is_dead)
			child.queue_free()
			break
