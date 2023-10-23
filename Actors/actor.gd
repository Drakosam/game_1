extends Node2D

var role = 'actor'
var core = 'actor_core'
var tile_posytion = ''

signal move_to_new_region()

func _ready():
	pass # Replace with function body.


func move_to_region(new_region_name):
	tile_posytion = new_region_name
	emit_signal('move_to_new_region')
