extends Panel

signal view_is_blocked(status)

var CoreGame = null

func _ready():
	pass 


func _process(_delta):
	if CoreGame:
		$HBoxContainer/ResourceValue.text = str(CoreGame.resource)
		$HBoxContainer/FoodValue.text = str(CoreGame.food)
	

func _mouse_entered():
	emit_signal('view_is_blocked',true)


func _mouse_exited():
	emit_signal('view_is_blocked',false)


func set_backend(_backend):
	CoreGame = _backend

