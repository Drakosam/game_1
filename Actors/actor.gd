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

var helth = 10
var maxHelth = 10

var morale = 100
var maxMorale = 100

var heat = 0
var maxHeat = 100
var live = true

signal move_to_new_region()
signal job_done_result(job_result)
signal check_path_to_target_posytion(start_tile, target_tile, my_name)
signal im_dead(my_name)

var job_backend = null

var rng = RandomNumberGenerator.new()

func _ready():
	var JobBackend = preload("res://Backend/job_backend.tscn")
	job_backend = JobBackend.instantiate()
	job_backend.connect('job_done_result',_on_job_done_result)
	add_child(job_backend) 


func move_to_region(new_region_name):
	emit_signal('check_path_to_target_posytion', tile_posytion, new_region_name, name)
	set_job_to_do(JobNames.move)


func set_target_region_path(recypient_name, in_target_path):
	if recypient_name == name:
		path_to_posytion = in_target_path
		print(name,' recive path ',in_target_path)


func act():
	if not live:
		return
	
	if helth < 1:
		emit_signal("im_dead",name)
		return
		
	if job_backend :		
		job_backend.act({
			'speed':speed,
			'power':power,
			'influance':influance,
			'mental':mental,
			'aether':aether
		})
		
		if jobs_to_do_list.size() > 0 and job_backend.current_job == JobNames.idle:
			job_backend.start_job(jobs_to_do_list.pop_front())


func get_job_core():
	return job_backend


func add_job_to_do(job_name):
	jobs_to_do_list.append(job_name)


func set_job_to_do(job_name):
	jobs_to_do_list.clear()
	job_backend.stop_job()
	jobs_to_do_list.append(job_name)


func _on_job_done_result(job_result):
	if job_result['name'] == JobNames.move:
		_move()
		return
	
	if job_result['repeat']:
		jobs_to_do_list.push_front(job_result['name'])
	
	emit_signal('job_done_result',{
		'name':name, 
		'tile':tile_posytion , 
		'job_type': job_result['name'],
		'agent_power':power,
		'results':job_result['result']})


func _move():
	tile_posytion = path_to_posytion.pop_front()
	emit_signal('move_to_new_region')
	
	if path_to_posytion.size()>0:
		jobs_to_do_list.push_front(JobNames.move)


func up_stat():
	rng.randomize()
	var result = rng.randi_range(0,4)
	
	if result == 0:
		speed += 1
	elif result == 1:
		power += 1
	elif result == 2:
		influance += 1 
	elif result == 3:
		mental += 1
	elif result == 4:
		aether += 1
	
