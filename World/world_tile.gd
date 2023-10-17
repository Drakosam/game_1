extends Node2D

var focus = false
var picked = false
var picked_neighborhood = false
var view_is_blocked = false

var agent_in_region = false

var rng = RandomNumberGenerator.new()

signal picked_hex(hex_name, pick_position)

func _ready():
	pass
	
	
func _on_area_2d_mouse_entered():
	focus = true


func _on_area_2d_mouse_exited():
	focus = false


func _input(event):
	if focus and not view_is_blocked:
		if (event is InputEventMouseButton) and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) :
			emit_signal("picked_hex", name, position)
			print('region picked :: ', name)


func hex_has_ben_picked(hex_name, pick_position):
	if hex_name == name:
		picked = true
	else :
		picked = false
	
	if 140>position.distance_to(pick_position) and  position.distance_to(pick_position)>1 :
		picked_neighborhood = true
	else :
		picked_neighborhood = false
	

func _process(_delta):
	
	if picked and focus and not view_is_blocked:
		$TileFront.color = Color('#8888ff')
	elif picked_neighborhood and focus and not view_is_blocked:
		$TileFront.color = Color('#ff8888')
	elif focus and not view_is_blocked:
		$TileFront.color = Color('#ddddff')
	elif picked :
		$TileFront.color = Color('#888888')
	elif picked_neighborhood :
		$TileFront.color = Color('#ffdddd')
	else:
		$TileFront.color = Color('#ffffff')
	
	if agent_in_region :
		$AgentIcone.visible = true
	else:
		$AgentIcone.visible = false
	
func view_is_bloced(status):
	view_is_blocked = status

func set_my_name(my_new_name):
	name = my_new_name
	if rng.randi_range(1, 20)< 5 and ('UnderCity' in name):
		visible = false


