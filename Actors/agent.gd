extends "res://Actors/actor.gd"

var consume_level = 500

signal consume_food_event(consume_value,agent_name)

func _ready():
	super()
	role = 'agent'
	rng.randomize()
	consume_level += rng.randi_range(-50, 50) 
	
	speed = rng.randi_range(1,4)
	power = rng.randi_range(1,4)
	influance = rng.randi_range(1,4)
	mental = rng.randi_range(1,4)
	aether = rng.randi_range(0,4)


func _consume():
	consume_level -= 1
	if consume_level < 0 :
		var consume_value = 4 + int(round(float(speed + power + influance + mental + aether ) / 2))
		emit_signal('consume_food_event',consume_value,name)
		consume_level = 500


func consume_result(consume_value, agent_name):
	if agent_name != name:
		return 
	
	print('me ::', name,' consume -> ',consume_value)
	if consume_value > 0:
		helth -=  round(consume_value/3) 
		morale -= (consume_value * 2)
		
		if morale < 0:
			morale = 0
	else:
		morale += 1
		if morale > maxMorale:
			morale = maxMorale


func act():
	if not live:
		return

	_consume()
	super()
	

func convert_resorces_to_food():
	set_job_to_do('RESOURCES_TO_FOOD')
	
	
func _on_job_done_result(job_result):
	
	if job_result['name'] == 'RESOURCES_TO_FOOD':
		jobs_to_do_list.push_front('RESOURCES_TO_FOOD')
	
	super(job_result)
