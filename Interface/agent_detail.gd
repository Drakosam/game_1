extends Panel

var show_agent = null
var cd_on = false

signal close_agent_detail()
signal move_pick_proc()

func _ready():
	pass 


func set_show_agent(agent_item):
	show_agent = agent_item
	$AgentInfoPanel.set_agent(show_agent)

func _on_button_pressed():
	if cd_on:
		return
	emit_signal("close_agent_detail")


func _move_agent():
	if cd_on:
		return
	emit_signal('move_pick_proc')
	

func move_agent_to_region(region_name):
	if region_name:
		show_agent.move_to_region(region_name)


func _on_button_explore_pressed():
	if cd_on:
		return
	show_agent.set_job_to_do(JobNames.explore)


func _on_cancel_work_pressed():
	if cd_on:
		return
	show_agent.set_job_to_do(JobNames.idle)


func _on_button_recruting_pressed():
	if cd_on:
		return
	show_agent.set_job_to_do(JobNames.recruiting)


func _on_button_training_pressed():
	if cd_on:
		return
	show_agent.set_job_to_do(JobNames.trening)


func _on_button_base_resources_pressed():
	if cd_on:
		return
	show_agent.set_job_to_do(JobNames.base_resource)


func _on_button_convert_res_to_tood_pressed():
	if cd_on:
		return
	show_agent.set_job_to_do(JobNames.resources_to_food)


func _on_visibility_changed():
	if visible:
		cd_on = true
		$Timer.start()


func _on_timer_timeout():
	cd_on = false
	print('up')
