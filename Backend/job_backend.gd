extends Node

var current_job = 'IDLE'
var job_progress = 0
var job_goal = 1

var primary_atribute = ''
var secondary_atribute = ''

var job_result_list = []

signal job_done_result(job_result)
var rng = RandomNumberGenerator.new()


func _ready():
	pass 


func job_done():
	print('job done ',current_job)
	
	if current_job == 'EXPLORE':
		_resolve_explore_job()
	elif current_job == 'RECRUITING':
		_resolve_recruiting_job()
	
	emit_signal('job_done_result',{'name':current_job,'result':job_result_list})
	stop_job()


func start_job(job_name):
	if job_name == 'MOVE':
		_start_movment() 
	elif job_name == 'EXPLORE':
		_start_explore() 
	elif job_name == 'RECRUITING':
		_start_recruiting() 


func act(stats = null):
	if current_job != 'IDLE':
		if not stats:
			stats = {}
		
		if primary_atribute in stats:
			job_progress += stats[primary_atribute]
		
		if secondary_atribute in stats:
			job_progress += round(stats[secondary_atribute]/2)
			
		if primary_atribute != 'aether' and secondary_atribute != 'aether':
			job_progress += stats['aether']

		if job_progress>job_goal:
			job_done()

func stop_job():
	print('IDLE')
	current_job = 'IDLE'
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
	job_goal = 500
	current_job = "MOVE"


func _start_explore():
	print('start exolore')
	primary_atribute = 'speed'
	secondary_atribute = 'mental'
	job_goal = 500
	current_job = "EXPLORE"


func _start_recruiting():
	print('start recruiting')
	primary_atribute = 'influance'
	secondary_atribute = 'mental'
	job_goal = 450
	current_job = "RECRUITING"
	
# Work resolve
func _resolve_explore_job():
	rng.randomize()
	var result = rng.randi_range(0, 100)
	
	if result > 94:
		job_result_list.append({'name':'new_region'})
	else:
		print(result)


func _resolve_recruiting_job():
	rng.randomize()
	var result = rng.randi_range(0, 100)
	
	if result >79:
		job_result_list.append({'status':'SUCCESS'})
	else:
		job_result_list.append({'status':'FAIL'})
	print(job_result_list)

