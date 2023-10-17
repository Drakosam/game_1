extends Node2D


var AgentClass = preload("res://Actors/agent.tscn")

signal update_agent_locations(agent_locations)

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
		
