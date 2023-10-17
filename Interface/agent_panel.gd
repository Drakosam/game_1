extends Panel

signal view_is_blocked(status)

func _ready():
	pass
	

func _on_scroll_container_mouse_entered():
	emit_signal('view_is_blocked',true)


func _on_scroll_container_mouse_exited():
	emit_signal('view_is_blocked',false)
