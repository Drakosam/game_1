extends Camera2D

var start_posytion = Vector2(0,0)
var can_move = false

func _ready():
	pass # Replace with function body.


func _input(event):
	if (event is InputEventMouseButton) and Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		start_posytion = get_global_mouse_position()
		can_move = true
	
	if can_move and not Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE) :
		can_move = false
	
	if event is InputEventMouseMotion and can_move:
		self.position += start_posytion - get_global_mouse_position()
