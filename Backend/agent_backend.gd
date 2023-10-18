extends Node2D


var AgentClass = preload("res://Actors/agent.tscn")
var show_region_name = ''

signal update_agent_locations(agent_locations)
signal update_agents_in_region(agents_list)

func _ready():
	pass 


func add_agent(agent_seed=null):
	if agent_seed == null:
		agent_seed = {}
	var new_agent = AgentClass.instantiate()
	add_child(new_agent)
	
	if 'location' in agent_seed:
		new_agent.tile_posytions = agent_seed['location']
	
	if 'name' in agent_seed:
		new_agent.name = agent_seed['name']
	
	update_agent_posytion()


func update_agent_posytion():
	var agent_locations = []
	for agent in get_children():
		agent_locations.append(agent.tile_posytions)
	
	emit_signal('update_agent_locations', agent_locations)
	
	
func pick_agent_list_for_region(region_name = ''):
	if show_region_name != region_name and region_name:
		show_region_name = region_name
		var agents_in_location = []
		for agent in get_children():
			if agent.tile_posytions == region_name:
				agents_in_location.append(agent)
		emit_signal("update_agents_in_region",agents_in_location)
