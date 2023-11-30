extends Panel


func _ready():
	pass # Replace with function body.


func _process(_delta):
	if GameCore.curent_tile:
		var new_val =  str( GameCore.curent_tile.resources)
		$VBoxContainer/Resource.text = 'Resource available :: ' + new_val
