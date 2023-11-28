extends "res://Actors/actor.gd"

var consume_level = 500

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
		var consume_food_value = CoreValue.food_base_conumption
		var consuption_from_attr = speed + power + influance + mental + aether 
		consuption_from_attr = float(consuption_from_attr) / 2
		consuption_from_attr *= CoreValue.food_conumption_attr_multi
		consume_food_value += roundi(consuption_from_attr)
		
		var consume_food_dif = 0
		
		if consume_food_value <= GameCore.food:
			GameCore.food -= consume_food_value
		else:
			consume_food_dif = consume_food_value - GameCore.food
			GameCore.food = 0
		
		consume_result(consume_food_dif)
		consume_level = 500


func consume_result(consume_value):
	
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
