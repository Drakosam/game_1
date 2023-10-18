extends Node2D

var show_lvl = 4
var list_level = []

signal registerTile(tile)
signal region_picked(region_name)


func _ready():
	$CloudLevel.set_level_with_size(3)
	$TopLevel.set_level_with_size(4)
	$CommerceLevel.set_level_with_size(5)
	$BaseLevel.set_level_with_size(6)
	$UndergroundLevel.set_level_with_size(5)
	$DeapUndergroundLvel.set_level_with_size(4)
	$UnderCitysLevel.set_level_with_size(4)
	
	list_level = [$CloudLevel,$TopLevel,$CommerceLevel,$BaseLevel,
	$UndergroundLevel,$DeapUndergroundLvel,$UnderCitysLevel]	


func view_is_bloced(status):
	for item in list_level:
		item.view_is_bloced(status)


func _input(event):
	if (event is InputEventKey) and Input.is_key_pressed(KEY_KP_ADD) :
		show_lvl +=1
		update_view()
	elif (event is InputEventKey) and Input.is_key_pressed(KEY_KP_SUBTRACT) :
		show_lvl -=1
		update_view()


func update_view():
	if show_lvl<1:
		show_lvl = 1
	elif show_lvl > 7 :
		show_lvl = 7
	
	for i in range(1,8):
		if i == show_lvl:
			list_level[i-1].visible = true
			print(list_level[i-1].name)
		else:
			list_level[i-1].visible = false


func _registerTile(tile):
	emit_signal('registerTile',tile)


func _region_picked(hex_name):
	emit_signal("region_picked",hex_name)
