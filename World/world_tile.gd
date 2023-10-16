extends Node2D

var focus = false
var picked = false
var my_name = ''

signal picked_hex(hex_name)

func _ready():
	my_name = str(get_parent().get_instance_id())+str(get_instance_id())
	
	
func _on_area_2d_mouse_entered():
	focus = true


func _on_area_2d_mouse_exited():
	focus = false


func _input(event):
	if focus:
		if (event is InputEventMouseButton) and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) :
			emit_signal("picked_hex",my_name)
			print(my_name)


func hex_has_ben_picked(hex_name):
	if hex_name == my_name:
		picked = true
	else :
		picked = false


func _process(delta):
	if picked and focus:
		$TileFront.color = Color('#084078')
	elif focus:
		$TileFront.color = Color('#91c2f2')
	elif picked :
		$TileFront.color = Color('#999999')
	else:
		$TileFront.color = Color('#ffffff')


func set_my_name(my_new_name):
	my_name = my_new_name
		
