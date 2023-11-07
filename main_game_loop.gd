extends Node2D
#Arcology city

func _ready():
	$AgentBackend.add_agent({'location':'BaseLevel_LC0_5'})
	$AgentBackend.add_agent({'location':'BaseLevel_LC0_5'})
	$AgentBackend.add_agent({'location':'BaseLevel_LC0_5'})
	$AgentBackend.add_agent({'location':'BaseLevel_LC0_5'})
	
	$CanvasLayer/TopPanel.set_backend($GameCore)
	
	$ManagerBackend.TileBackend = $TileBackend
	$ManagerBackend.AgentManager = $AgentBackend
	$ManagerBackend.CoreManager =  $GameCore
	

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


func _on_timer_timeout():
	$AgentBackend.act()


func _on_agent_backend_chec_path_to_tile(start_tile, target_tile, agent_name):
	print('reqest for path from ',start_tile,' to ',target_tile)
	var item = $TileBackend.get_path_to_tile(start_tile, target_tile, agent_name)
	$AgentBackend.set_tile_path(item['target_name'],item['path'])


func _on_agent_backend_job_done_result(job_result):
	print('main job resolve for :: ', job_result)
	$TileBackend.resolve_job_result(job_result)
	$GameCore.resolve_job_result(job_result)
	$ManagerBackend.resolve_job_result(job_result)


func _on_agent_backend_consume_food_event(consume_value, agent_name):
	var consume_dif = $GameCore.consume_food(consume_value)
	$AgentBackend.resolve_consume_event_for_agent(consume_dif, agent_name)


func _on_agent_backend_secure_food_for_new_agent(food_needed, location ):
	if $GameCore.food >= food_needed:
		$GameCore.food -= food_needed
		$AgentBackend.add_agent({'location':location})
