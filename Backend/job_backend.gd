extends Node

var current_job = ''
var job_progress = 0
var job_goal = 1

var primary_atribute = ''
var secondary_atribute = ''
var repeat = false


var job_result_list = []

signal job_done_result(job_result)
var rng = RandomNumberGenerator.new()


func _ready():
	current_job = JobNames.idle


func job_done():
	print('job done ',current_job)

	if current_job == JobNames.explore:
		_resolve_explore_job()

	elif current_job == JobNames.recruiting:
		_generic_resolve_job(79)

	elif current_job == JobNames.trening:
		var parent = get_parent()
		var mod = parent.speed + parent.power + parent.influance + parent.mental
		mod = (mod + parent.aether - 4) * 2 + 60 
		_generic_resolve_job(mod)
		for result in job_result_list:
			if result['status'] == 'SUCCESS':
				parent.up_stat()

	elif current_job == JobNames.base_resource:
		_generic_resolve_job(10)

	elif  current_job == JobNames.resources_to_food:
		_generic_resolve_job(5)

	emit_signal('job_done_result',{
		'name':current_job,
		'result':job_result_list,
		'repeat':repeat
		})
	stop_job()


func start_job(job_name):
	repeat = false
	
	if job_name == JobNames.move:
		_start_movment() 

	elif job_name == JobNames.explore:
		_start_explore() 
		repeat = true

	elif job_name == JobNames.recruiting:
		_start_recruiting() 
		repeat = true

	elif job_name == JobNames.trening:
		_general_training() 
		repeat = true

	elif job_name == JobNames.base_resource:
		_base_resources() 
		repeat = true

	elif job_name == JobNames.resources_to_food:
		_resources_to_food() 
		repeat = true


func act(stats = null):
	if current_job != JobNames.idle:
		if not stats:
			stats = {}

		if primary_atribute == '':
			job_progress += 1

		if primary_atribute in stats:
			job_progress += stats[primary_atribute]

		if secondary_atribute in stats:
			job_progress += round(stats[secondary_atribute]/2)

		if primary_atribute != 'aether' and secondary_atribute != 'aether':
			job_progress += stats['aether']

		if job_progress>job_goal:
			job_done()


func stop_job():
	print(JobNames.idle)
	current_job = JobNames.idle
	primary_atribute = ''
	secondary_atribute = ''
	job_progress = 0
	job_goal = 1
	job_result_list = []


#Work section
func _start_movment():
	print('start movment')
	primary_atribute = 'speed'
	secondary_atribute = 'mental'
	job_goal = int(500 * CoreValue.speed_progres_multi) 
	current_job = JobNames.move


func _start_explore():
	print('start exolore')
	primary_atribute = 'speed'
	secondary_atribute = 'mental'
	job_goal = int(500 * CoreValue.speed_progres_multi) 
	current_job = JobNames.explore


func _resources_to_food():
	print('start convert resource to food')
	primary_atribute = 'mental'
	secondary_atribute = 'speed'
	job_goal = int(100 * CoreValue.speed_progres_multi) 
	current_job = JobNames.resources_to_food


func _start_recruiting():
	print('start recruiting')
	primary_atribute = 'influance'
	secondary_atribute = 'mental'
	job_goal = int(450 * CoreValue.speed_progres_multi) 
	current_job = JobNames.recruiting


func _general_training():
	print('start general training')
	primary_atribute = ''
	secondary_atribute = ''
	job_goal = int(450 * CoreValue.speed_progres_multi) 
	current_job = JobNames.trening


func _base_resources():
	print('start base resources')
	primary_atribute = 'power'
	secondary_atribute = 'speed'
	job_goal = int(500 * CoreValue.speed_progres_multi) 
	current_job = JobNames.base_resource


# Work resolve
func _generic_resolve_job(succes_rate=50):
	rng.randomize()
	var result = rng.randi_range(0, 100)

	if result > succes_rate:
		job_result_list.append({'status':'SUCCESS'})
	else:
		job_result_list.append({'status':'FAIL'})
	print(job_result_list, ' ', result, ' ' , succes_rate)


func _resolve_explore_job():
	rng.randomize()
	var result = rng.randi_range(0, 100)

	if result > 94:
		job_result_list.append({'name': 'new_region'})
	elif result > 60:
		job_result_list.append({'name': 'new_resources'})
	else:
		print(result)
