extends Node

var resource = 0
var food = 200
var rng = RandomNumberGenerator.new()

func _ready():
	pass 


func resolve_job_result(job_result):
	if 'RESOURCES_TO_FOOD' == job_result['job_type']:
		for item in job_result['results']:
			if item['status'] == 'SUCCESS':
				_convert_resources_to_food(job_result['agent_power'])


func consume_food(_food):
	if _food <= food:
		food -= _food
		return 0
	else:
		food = 0
		return _food - food


func _convert_resources_to_food(agent_power):
	if resource >= 10 + agent_power:
		resource -= (10 + agent_power)
		food += (10 + agent_power) * 3
	else:
		food += resource * 3
		resource -= resource
	
