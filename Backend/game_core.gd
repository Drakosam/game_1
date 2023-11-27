extends Node

var resource = 0
var food = 0
var rng = RandomNumberGenerator.new()

func _ready():
	food = CoreValue.start_food_value


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
	
	var rtfm = CoreValue.resources_to_food_multi
	var rtfbv = CoreValue.resources_to_food_base_value
	
	if resource >= rtfbv + agent_power:
		resource -= (rtfbv + agent_power)
		food += (rtfbv + agent_power) * rtfm
	else:
		food += resource * rtfm
		resource -= resource
	
