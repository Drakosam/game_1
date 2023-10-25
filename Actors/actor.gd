extends Node

var role = 'actor'
var core = 'actor_core'
var tile_posytion = ''

var jobs_to_do_list = []
var path_to_posytion = []

var speed = 1
var power = 1
var influance = 1
var mental = 1
var aether = 0

signal move_to_new_region()

signal job_done_result(job_result)
signal check_path_to_target_posytion(start_tile, target_tile, my_name)

var job_backend = null

func _ready():
	var JobBackend = preload("res://Backend/job_backend.tscn")
	job_backend = JobBackend.instantiate()
	job_backend.connect('job_done_result',_on_job_done_result)


func move_to_region(new_region_name):
	emit_signal('check_path_to_target_posytion', tile_posytion, new_region_name, name)
	add_job_to_do('MOVE')


func set_target_region_path(recypient_name, in_target_path):
	if recypient_name == name:
		path_to_posytion = in_target_path
		print(name,' recive path ',in_target_path)


func act():
	if job_backend :		
		job_backend.act({
			'speed':speed,
			'power':power,
			'influance':influance,
			'mental':mental,
			'aether':aether
		})
		
		if jobs_to_do_list.size() > 0 and job_backend.current_job == 'IDLE':
			job_backend.start_job(jobs_to_do_list.pop_front())
	

func get_job_core():
	return job_backend


func add_job_to_do(job_name):
	jobs_to_do_list.append(job_name)


func _on_job_done_result(job_result):
	if job_result['name'] == 'MOVE':
		_move()
	else:
		emit_signal('job_done_result',job_done_result)


func _move():
	tile_posytion = path_to_posytion.pop_front()
	emit_signal('move_to_new_region')
	if path_to_posytion.size()>0:
		jobs_to_do_list.push_front('MOVE')
		
		
