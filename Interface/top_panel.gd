extends Panel

signal view_is_blocked(status)

func _ready():
	pass 


func _mouse_entered():
	emit_signal('view_is_blocked',true)


func _mouse_exited():
	emit_signal('view_is_blocked',false)
