extends Area2D

var rotating = false
var player:Node2D
var dir:Vector2
var speed = 200
var angle = 0
var hitting = false

export (NodePath)onready var swordgen_path
var swordgen:Node2D
func _ready():
	swordgen = get_node(swordgen_path)

func assign_player(p):
	player = p
	
func hit(direction):
	dir = direction * speed
	start_rotation()
	
func set_dir(pos, a):
	position = pos
	angle = a
	
func start_linear():
	hitting = true
	$anim.seek(0)
	$anim.play("fall")
	set_linear()
	
func set_linear():
	rotating = false
	$shape.disabled = false
	$shape_circle.disabled = true
	$sprite.rotation = 0

func start_horizontal():
	$anim.seek(0)
	$anim.play("horizontal")
	set_horizontal()

func set_horizontal():
	rotating = false
	$shape.disabled = false
	$shape_circle.disabled = true
	$sprite.rotation = 0
	rotation = PI / 2
	
func start_rotation():
	$anim.seek(0)
	$anim.play("rotate")
	set_rotate()
	
func set_rotate():
	rotating = true
	$shape.disabled = true
	$shape_circle.disabled = false

func start_delay(time):
	$timer.wait_time = time
	$timer.connect("timeout", self, "start_linear")
	$timer.start()
	
func reset():
	set_linear()
	position.y = - 50
	$anim.stop()
	hitting = false



func _process(_d):
	if rotating:
		set_position(position + dir * _d)
		dir.y += g.gravity * 0.7
		if position.y > 148:
			swordgen.add_sword(position.x, $sprite.rotation)
			reset()
			
