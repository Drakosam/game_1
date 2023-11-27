extends Node

var TileBackend = null
var AgentManager = null

var rng = RandomNumberGenerator.new()

func _ready():
	pass
	

func resolve_job_result(job_result):
	if 'BASE_RESOURCES' == job_result['job_type']:
		for item in job_result['results']:
			if item['status'] == 'SUCCESS':
				_get_base_resource_from_region(
					job_result['tile'], 
					job_result['agent_power']
				)


func _get_base_resource_from_region(_region_name, agent_power):
	rng.randomize()
	var get_value = randi_range(3,6) + agent_power
	var dif_value = TileBackend.get_resource_from_region(_region_name, get_value)
	print(get_value,' ',dif_value)
	GameCore.resource +=  (get_value - dif_value)
