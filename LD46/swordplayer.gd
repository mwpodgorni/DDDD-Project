extends Node2D
onready var player = get_node("../player")
onready var g = get_node("/root/g")
onready var main = get_node("../../Main")
var swords = []
var is_done = - 1
var timers = []
var base_timer = 0
var wave = 0
var WAVE_MAX = 7
func _ready():
	swords = [
get_node("0"), 
get_node("1"), 
get_node("2"), 
get_node("3"), 
get_node("4"), 
get_node("5"), 
get_node("6")]
	for i in range(0, swords.size()):
		swords[i].assign_player(player)
		timers.push_back(Timer.new())
		timers[i].one_shot = true
		add_child(timers[i])
	$timer.connect("timeout", self, "next_wave")
	$timer.start()
func _process(_d):
	pass
	
func next_wave():
	for i in range(0, swords.size()):
		swords[i].position.y = - 50
	match wave:
		0:
			wave0()
		1:
			wave1()
		2:
			wave2()
		3:
			wave0()
		4:
			wave1()
		5:
			wave2()
		6:
			wave2()
		7:
			win()
	wave += 1
	if g.lost == 0:
		$timer.wait_time = 6
		$timer.connect("timeout", self, "next_wave")
		$timer.start()
		
		
func win():
	g.lost = 3
	main.updateCurrentGameField("wonGame", true)
func wave0():
	for i in range(0, swords.size()):
		main.increaseGameFieldValue("droppedSwords")
		swords[i].position.x = i * 40 + 40
		swords[i].start_delay(i * 0.5 + 0.1)
func wave1():
	main.increaseGameFieldValue("wonWaves")
	for i in range(0, swords.size()):
		main.increaseGameFieldValue("droppedSwords")
		swords[i].position.x = 280 - i * 40
		swords[i].start_delay(i * 0.5 + 0.1)
func wave2():
	main.increaseGameFieldValue("wonWaves")
	for i in range(0, swords.size()):
		main.increaseGameFieldValue("droppedSwords")
		swords[i].position.x = i * 10 + 106
		if i > 3:
			swords[i].start_delay(3.1 - i * 0.5)
		else :
			swords[i].start_delay(i * 0.5 + 0.1)
func wave3():
	main.increaseGameFieldValue("wonWaves")
	for i in range(0, swords.size()):
		main.increaseGameFieldValue("droppedSwords")
		swords[i].position.x = 280 - i * 40
		swords[i].start_delay(i * 0.5 + 0.1)
func wave4():
	main.increaseGameFieldValue("wonWaves")
	for i in range(0, swords.size()):
		main.increaseGameFieldValue("droppedSwords")
		swords[i].position.x = i * 40 + 40
		swords[i].start_delay(i * 0.5 + 0.1)
func wave5():
	main.increaseGameFieldValue("wonWaves")
	for i in range(0, swords.size()):
		main.increaseGameFieldValue("droppedSwords")
		swords[i].position.x = 280 - i * 40
		swords[i].start_delay(i * 0.5 + 0.1)
func wave6():
	main.increaseGameFieldValue("wonWaves")
	for i in range(0, swords.size()):
		main.increaseGameFieldValue("droppedSwords")
		swords[i].position.x = i * 40 + 40
		swords[i].start_delay(i * 0.5 + 0.1)
func wave7():
	main.increaseGameFieldValue("wonWaves")
	for i in range(0, swords.size()):
		main.increaseGameFieldValue("droppedSwords")
		swords[i].position.x = 280 - i * 40
		swords[i].start_delay(i * 0.5 + 0.1)

func currentWave():
	return wave
