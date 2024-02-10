extends Node2D
onready var player = get_node("../player")
onready var gl = get_node("/root/gl")

var waves = [
	"wave0", 
	"wave1", 
	"wave2", 
	"wave0", 
	"wave1", 
	"wave2", 
	"win"
]
var swords = []
var is_done = - 1
var timers = []
var base_timer = 0
var wave = 0

func _ready():
	swords = [
		$"0", 
		$"1", 
		$"2", 
		$"3", 
		$"4", 
		$"5", 
		$"6"
	]
	$timer.wait_time = 0.1
	$timer.connect("timeout", self, "next_wave")
	$timer.start()
	
func _process(_d):
	pass

func next_wave():
	for i in range(0, swords.size()):
		swords[i].reset()
	call(waves[0])
	wave += 1
	if gl.lost == 0:
		$timer.wait_time = 6
		$timer.start()
		
func win():
	gl.lost = 3
func wave0():
	for i in range(0, swords.size()):
		swords[i].set_dir_end(Vector2(160, 140), PI / 6 * (i - 3), 100)

		swords[i].start_delay(i * 0.5 + 0.1)
func wave1():
	for i in range(0, swords.size()):
		swords[i].position.x = 280 - i * 40
		swords[i].start_delay(i * 0.5 + 0.1)
func wave2():
	for i in range(0, swords.size()):
		swords[i].position.x = i * 10 + 106
		if i > 3:
			swords[i].start_delay(3.1 - i * 0.5)
		else :
			swords[i].start_delay(i * 0.5 + 0.1)
func wave3():
	for i in range(0, swords.size()):
		swords[i].position.x = 280 - i * 40
		swords[i].start_delay(i * 0.5 + 0.1)
func wave4():
	for i in range(0, swords.size()):
		swords[i].position.x = i * 40 + 40
		swords[i].start_delay(i * 0.5 + 0.1)
func wave5():
	for i in range(0, swords.size()):
		swords[i].position.x = 280 - i * 40
		swords[i].start_delay(i * 0.5 + 0.1)
func wave6():
	for i in range(0, swords.size()):
		swords[i].position.x = i * 40 + 40
		swords[i].start_delay(i * 0.5 + 0.1)
func wave7():
	for i in range(0, swords.size()):
		swords[i].position.x = 280 - i * 40
		swords[i].start_delay(i * 0.5 + 0.1)
