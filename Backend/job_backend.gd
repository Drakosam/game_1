extends Node

#-----------------------------------------------------------------------------
#success rate
var threshold_explore_new_region = 94
var threshold_explore_new_resorce = 60
var threshold_base_trening = 60
var threshold_colect_base_resorce = 10
var threshold_convert_resorce_to_food = 5
var threshold_recruting = 70


var work_steps_very_hard = 500
var work_steps_hard = 400
var work_steps_medium = 300
var work_steps_easy = 200
var work_steps_very_easy = 100

#-----------------------------------------------------------------------------
#varibles---------------------------------------------------------------------
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
		_generic_resolve_job(threshold_recruting)

	elif current_job == JobNames.trening:
		_resolve_treining_job()

	elif current_job == JobNames.base_resource:
		_generic_resolve_job(threshold_colect_base_resorce)

	elif  current_job == JobNames.resources_to_food:
		_generic_resolve_job(threshold_convert_resorce_to_food)

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


func act():
	_job_steps()


func _job_steps():
	if current_job != JobNames.idle:
		var parent = get_parent()

		if primary_atribute == '':
			job_progress += 1
		
		if primary_atribute == 'speed':
			job_progress += parent.speed
			
		if primary_atribute == 'power':
			job_progress += parent.power
			
		if primary_atribute == 'influance':
			job_progress += parent.influance
		
		if primary_atribute == 'mental':
			job_progress += parent.mental
		
		if primary_atribute == 'aether':
			job_progress += parent.aether
		
		if secondary_atribute == 'speed':
			job_progress += round(parent.speed/2)
			
		if secondary_atribute == 'power':
			job_progress += round(parent.power/2)
			
		if secondary_atribute == 'influance':
			job_progress += round(parent.influance/2)
		
		if secondary_atribute == 'mental':
			job_progress += round(parent.mental/2)
		
		if secondary_atribute == 'aether':
			job_progress += round(parent.aether/2)

		if primary_atribute != 'aether' and secondary_atribute != 'aether':
			job_progress += parent.aether

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
	
	job_goal = int( work_steps_medium * CoreValue.speed_progres_multi) 
	current_job = JobNames.move


func _start_explore():
	print('start exolore')
	primary_atribute = 'speed'
	secondary_atribute = 'mental'
	
	job_goal = int(work_steps_hard * CoreValue.speed_progres_multi) 
	current_job = JobNames.explore


func _resources_to_food():
	print('start convert resource to food')
	primary_atribute = 'mental'
	secondary_atribute = 'speed'
	
	job_goal = int(work_steps_very_easy * CoreValue.speed_progres_multi) 
	current_job = JobNames.resources_to_food


func _start_recruiting():
	print('start recruiting')
	primary_atribute = 'influance'
	secondary_atribute = 'mental'
	
	job_goal = int(work_steps_very_hard * CoreValue.speed_progres_multi) 
	current_job = JobNames.recruiting


func _general_training():
	print('start general training')
	primary_atribute = ''
	secondary_atribute = ''
	
	job_goal = int(work_steps_very_hard * CoreValue.speed_progres_multi) 
	current_job = JobNames.trening


func _base_resources():
	print('start base resources')
	primary_atribute = 'power'
	secondary_atribute = 'speed'
	
	job_goal = int(work_steps_hard * CoreValue.speed_progres_multi) 
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


func _resolve_treining_job():
	var parent = get_parent()
	var mod = parent.speed + parent.power + parent.influance + parent.mental
	mod = (mod + parent.aether - 4) * 2 + threshold_base_trening 
	_generic_resolve_job(mod)
	for result in job_result_list:
		if result['status'] == 'SUCCESS':
			parent.up_stat()
	
	
func _resolve_explore_job():
	rng.randomize()
	var result = rng.randi_range(0, 100)

	if result > threshold_explore_new_region:
		job_result_list.append({'name': 'new_region'})
	elif result > threshold_explore_new_resorce:
		job_result_list.append({'name': 'new_resources'})
	else:
		print(result)
