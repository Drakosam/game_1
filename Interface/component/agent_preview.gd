extends Panel

var block_vision = false
var aggent_preview = null

signal update_block_vision()

func _ready():
	$VBoxContainer/ProgressBar.visible = false


func _process(delta):
	if aggent_preview:
		$VBoxContainer/AgentName.text = str(aggent_preview.name)
		

func set_agent(new_agent):
	aggent_preview = new_agent
	

func _on_panel_mouse_entered():
	block_vision = true
	emit_signal('update_block_vision')


func _on_panel_mouse_exited():
	block_vision = false
	emit_signal('update_block_vision')
