extends Panel

var block_vision = false
var aggent_preview = null
var job_backend = null

signal update_block_vision()
signal show_agent(agent_item)

func _ready():
	$VBoxContainer/ProgressBar.visible = false


func _process(delta):
	if aggent_preview:
		$VBoxContainer/AgentName.text = str(aggent_preview.name)
		
		if job_backend.current_job != "IDLE":
			$VBoxContainer/ProgressBar.max_value = job_backend.job_goal
			$VBoxContainer/ProgressBar.value = job_backend.job_progress
			$VBoxContainer/ProgressBar.visible = true
			$VBoxContainer/Job_Idle.visible =false
		else:
			$VBoxContainer/ProgressBar.visible = false
			$VBoxContainer/Job_Idle.visible =true


func set_agent(new_agent):
	aggent_preview = new_agent
	job_backend = aggent_preview.get_job_core()
	

func _on_panel_mouse_entered():
	block_vision = true
	emit_signal('update_block_vision')


func _on_panel_mouse_exited():
	block_vision = false
	emit_signal('update_block_vision')


func _input(event):
	if block_vision :
		if (event is InputEventMouseButton) and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) :
			emit_signal("show_agent", aggent_preview)
			block_vision = false
	
