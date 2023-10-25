extends Node

var current_job = 'IDLE'
var job_progress = 0
var job_goal = 0

var primary_atribute = ''
var secondary_atribute = ''

var job_result_list = []

signal job_done_result(job_result)


func _ready():
	pass 


func job_done():
	print('job done ',current_job)
	emit_signal('job_done_result',{'name':current_job,'result':job_result_list})
	current_job = 'IDLE'
	primary_atribute = ''
	secondary_atribute = ''
	job_progress = 0
	job_goal = 0
	job_result_list = []


func _start_movment():
	print('start movment')
	primary_atribute = 'speed'
	secondary_atribute = 'mental'
	job_goal = 500
	current_job = "MOVE"


func start_job(job_name):
	if job_name == 'MOVE':
		_start_movment() 


func act(stats= null):
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
		
		
