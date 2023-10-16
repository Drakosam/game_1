extends Node2D

var Tile = preload("res://World/world_tile.tscn")

func _ready():
	set_level_with_size(5)


func set_level_with_size(level_size):
	var hex_d = 128
	if level_size == 1:
		put_tile_in_level(0, 0)
		
	else:
		draw_hex_line(2*level_size-1,- hex_d+hex_d, -hex_d * (level_size-1),'LC0_')
		
		for i in range(level_size-1):
			var ii = (level_size*2-2)-i
			
			if ii < level_size:
				break				 
			draw_hex_line(ii, (hex_d-16)*(i+1), -hex_d/2*ii+hex_d/2, 'LR'+str(i)+"_")
			draw_hex_line(ii, (-hex_d+16)*(i+1), -hex_d/2*ii+hex_d/2, 'LL'+str(i)+"_")


func _picked_hex_proc(hex_name, pick_position):
	for hex in get_children():
		hex.hex_has_ben_picked(hex_name, pick_position)
	
	

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
