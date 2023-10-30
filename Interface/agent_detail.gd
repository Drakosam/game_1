extends Panel

var show_agent = null

signal close_agent_detail()
signal move_pick_proc()

func _ready():
	pass 


func set_show_agent(agent_item):
	show_agent = agent_item


func _on_button_pressed():
	emit_signal("close_agent_detail")


func _move_agent():
	emit_signal('move_pick_proc')
	

func move_agent_to_region(region_name):
	if region_name:
		show_agent.move_to_region(region_name)


func _on_button_explore_pressed():
	show_agent.explore_tile()


func _on_cancel_work_pressed():
	show_agent.go_idle()


func _on_button_recruting_pressed():
	show_agent.recruit()
