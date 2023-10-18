extends Panel

var AgentPreviewClass = preload('res://Interface/component/agent_preview.tscn')

signal view_is_blocked(status)

func _ready():
	pass
	

func _mouse_entered():
	emit_signal('view_is_blocked',true)


func _mouse_exited():
	emit_signal('view_is_blocked',false)


func _add_preview(_agent):
	var agent_preview = AgentPreviewClass.instantiate()
	agent_preview.connect('update_block_vision',_update_block_view_signal)
	agent_preview.set_agent(_agent)
	
	$ScrollContainer/GridContainer.add_child(agent_preview)


func _remove_preview(child):
	child.disconnect('update_block_vision',_update_block_view_signal)
	$ScrollContainer/GridContainer.remove_child(child)
	child.queue_free()


func _update_block_view_signal():
	var block = false
	for child in $ScrollContainer/GridContainer.get_children():
		block = block or child.block_vision
	
	emit_signal('view_is_blocked',block)


func set_agents(agents_list):
	for child in $ScrollContainer/GridContainer.get_children():
		_remove_preview(child)
		
	for agent in agents_list:
		_add_preview(agent)
