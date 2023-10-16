extends Node2D

var focus = false
var picked = false
var picked_neighborhood = false
var my_name = ''

var rng = RandomNumberGenerator.new()

signal picked_hex(hex_name, pick_position)

func _ready():
	pass
	
func _on_area_2d_mouse_entered():
	focus = true


func _on_area_2d_mouse_exited():
	focus = false


func _input(event):
	if focus:
		if (event is InputEventMouseButton) and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) :
			emit_signal("picked_hex", my_name, position)


func hex_has_ben_picked(hex_name, pick_position):
	if hex_name == my_name:
		picked = true
	else :
		picked = false
	
	if 140>position.distance_to(pick_position) and  position.distance_to(pick_position)>1 :
		picked_neighborhood = true
	else :
		picked_neighborhood = false
	

func _process(delta):
	if picked and focus:
		$TileFront.color = Color('#8888ff')
	elif picked_neighborhood and focus:
		$TileFront.color = Color('#ff8888')
	elif focus:
		$TileFront.color = Color('#ddddff')
	elif picked :
		$TileFront.color = Color('#888888')
	elif picked_neighborhood :
		$TileFront.color = Color('#ffdddd')
	else:
		$TileFront.color = Color('#ffffff')


func set_my_name(my_new_name):
	my_name = my_new_name
	if rng.randi_range(1,20)< 5 and ('UnderCity' in my_name):
		visible = false
		
