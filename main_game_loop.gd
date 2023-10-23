extends Node2D
#Arcology city

func _ready():
	$AgentBackend.add_agent({
		'location':'BaseLevel_LC0_5',
		'name':'Agent_001'
	})
	$AgentBackend.add_agent({
		'location':'BaseLevel_LC0_5',
		'name':'Agent_002'
	})
	$AgentBackend.add_agent({
		'location':'BaseLevel_LC0_5',
		'name':'Agent_003'
	})
	$AgentBackend.add_agent({
		'location':'BaseLevel_LC0_5',
		'name':'Agent_004'
	})
	

func _on_world_map_register_tile(tile):
	$TileBackend.register_tile(tile)


func _on_agent_backend_update_agent_locations(agent_locations):
	$TileBackend.update_agent_posytions(agent_locations)


func _on_view_is_blocked(status):
	$WorldMap.view_is_bloced(status)


func _on_world_map_region_picked(region_name):
	$AgentBackend.pick_agent_list_for_region(region_name)
	

func _on_agent_backend_update_agents_in_region(agents_list):
	$CanvasLayer/AgentPanel.set_agents(agents_list)


func _on_agent_panel_show_agent(agent_item):
	$CanvasLayer/AgentDetail.set_show_agent(agent_item)
	$CanvasLayer/AgentDetail.visible = true
	$CanvasLayer/AgentPanel.visible = false
	$WorldMap.view_is_bloced(true)


func _on_agent_detail_close_agent_detail():
	$CanvasLayer/AgentDetail.visible = false
	$CanvasLayer/AgentPanel.visible = true
	$WorldMap.view_is_bloced(false)


func _on_agent_detail_move_pick_proc():
	$TileBackend.start_move_proces()
	$CanvasLayer/AgentDetail.visible = false
	$CanvasLayer/AgentPanel.visible = false


func _on_tile_backend_selected_region_whos_picked(hex_name):
	$CanvasLayer/AgentDetail.visible = true
	$CanvasLayer/AgentPanel.visible = false
	$CanvasLayer/AgentDetail.move_agent_to_region(hex_name)
