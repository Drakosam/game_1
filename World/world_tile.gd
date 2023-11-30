extends Node2D

var focus = false
var picked = false
var picked_neighborhood = false
var view_is_blocked = false
var move_process = false

var agent_in_region = false
var world_posytion_center = 0

var my_neighborhood = []
var region_level = ''
var resources = 0

var rng = RandomNumberGenerator.new()

signal picked_hex(hex_name, pick_position)
signal picket_move(hex_name)

func _ready():
	resources = rng.randi_range(
		CoreValue.min_start_resources_in_tile,
		CoreValue.max_start_resources_in_tile
	)
	
	
func _on_area_2d_mouse_entered():
	focus = true


func _on_area_2d_mouse_exited():
	focus = false


func _input(event):
	if focus and not view_is_blocked:
		if (event is InputEventMouseButton) and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) :
			emit_signal("picked_hex", name, position)
			GameCore.curent_tile = self
	elif focus and move_process:
		if (event is InputEventMouseButton) and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) :
			emit_signal("picket_move", '')
		elif (event is InputEventMouseButton) and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) :
			emit_signal("picket_move", name)
	

func hex_has_ben_picked(hex_name, pick_position):
	if hex_name == name:
		picked = true
	else :
		picked = false

	if 140>position.distance_to(pick_position) and  position.distance_to(pick_position)>1 :
		picked_neighborhood = true
	else :
		picked_neighborhood = false


func set_world_posytion_from_center():
	world_posytion_center =  round(get_distance_from_me(Vector2(0,0)) ) 


func get_distance_from_me(vec_pos):
	return position.distance_to(vec_pos)/127+.15


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


func add_to_my_neighborhood(neighbor):
	if neighbor not in my_neighborhood:
		my_neighborhood.append(neighbor)
