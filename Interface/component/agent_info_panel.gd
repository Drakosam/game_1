extends Panel


var curent_agent = null

func _ready():
	$HelthBar.value = $HelthBar.max_value
	$HeatBar.value = 0
	$MoraleBar.value = 0
	$JobProgressBar.value = 0


func set_agent(new_agent):
	curent_agent = new_agent


func _process(_delta):
	$HelthLabel.text = str($HelthBar.value)+' / '+str($HelthBar.max_value)
	
	if not self.visible:
		return
		
	if curent_agent != null:
		$HBoxContainer/SpeedLabel.text ='Speed: ' + str(curent_agent.speed)
		$HBoxContainer/PowerLabel.text = 'Power: ' + str(curent_agent.power)
		$HBoxContainer/InfluanceLabel.text ='Influance: ' + str(curent_agent.influance)
		$HBoxContainer/MentalLabel.text ='Mental: ' + str(curent_agent.mental)
		$HBoxContainer/AetherLabel.text ='Aether: ' + str(curent_agent.aether)

		$HelthBar.max_value = curent_agent.maxHelth
		$HelthBar.value = curent_agent.helth

		$HeatBar.max_value = curent_agent.maxHeat
		$HeatBar.value = curent_agent.heat

		$MoraleBar.max_value = curent_agent.maxMorale
		$MoraleBar.value = curent_agent.morale

		$JobProgressBar.max_value = curent_agent.job_backend.job_goal
		$JobProgressBar.value = curent_agent.job_backend.job_progress

