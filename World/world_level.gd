extends Node2D

var Tile = preload("res://World/world_tile.tscn")

signal registerTile(tile)
signal region_picked(region_name)

func _ready():
	pass


func view_is_bloced(status):
	for child in get_children():
		child.view_is_bloced(status)
		

func set_level_with_size(level_size):
	var hex_d = 128
	if level_size == 1:
		put_tile_in_level(0, 0)
		
	else:
		draw_hex_line(2*level_size-1,- hex_d+hex_d, -hex_d * (level_size-1),str(name)+'_LC0_')
		
		for i in range(level_size-1):
			var ii = (level_size*2-2)-i
			
			if ii < level_size:
				break				 
			draw_hex_line(ii, (hex_d-16)*(i+1), int(-float(hex_d)/2*ii+float(hex_d)/2), str(name)+'_LR'+str(i)+"_")
			draw_hex_line(ii, (-hex_d+16)*(i+1), int(-float(hex_d)/2*ii+float(hex_d)/2), str(name)+'_LL'+str(i)+"_")
	
	set_neighborhood_for_children()


func _picked_hex_proc(hex_name, pick_position):
	for hex in get_children():
		hex.hex_has_ben_picked(hex_name, pick_position)
	
	emit_signal('region_picked',hex_name)
	

func draw_hex_line(line_size, start_x, start_y,tile_name=''):
	var hex_d = 128
	
	for i in range(line_size):
		put_tile_in_level(start_x, start_y+(hex_d*i), tile_name+str(i))


func put_tile_in_level(pos_x, pos_y, tile_name=''):
	var new_tile = Tile.instantiate()
	new_tile.position=Vector2(pos_x,pos_y)
	add_child(new_tile)
	new_tile.connect('picked_hex',_picked_hex_proc)
	new_tile.set_my_name(tile_name)
	new_tile.set_world_posytion_from_center()
	new_tile.region_level = name
	
	emit_signal('registerTile', new_tile)


func set_neighborhood_for_children():
	for child in get_children():
		for child_ in get_children():
			var dist = round(child.position.distance_to(child_.position)/127+.15) 
			if dist == 1:
				child.add_to_my_neighborhood(child_)
