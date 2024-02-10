extends Area2D

var swordgen:Node2D

var rotating = false
var dir:Vector2
var speed = 200
var BASE_SPEED = 200
var length = 50
var start_pos = Vector2(0, 0)
var thrown:int = - 1
var rotate_speed = 10 * PI
var speed_factor = 1.01
export (NodePath)onready var swordgen_path

func _ready():
	$timer.connect("timeout", self, "start_linear")
	swordgen = get_node(swordgen_path)
	$sprite.set_material($sprite.get_material().duplicate(true))
	
func hit(direction):
	dir = direction * speed
	$shader_light_tween.interpolate_property($sprite.get_material(), "shader_param/white_amount", 1.0, 0.0, 0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$shader_light_tween.start()
	start_rotation()
	
func set_dir_random():
	set_dir_end(Vector2(randi() % 280 + 20, 140), PI / 2 * rand_range( - 1, 1), 50 * rand_range(0.5, 2))
	
func set_dir_start(pos, a = 0):
	start_pos = pos
	dir = Vector2(sin(a), cos(a))

func set_dir_end(end_pos, a = 0, l = 50):
	start_pos = end_pos - Vector2(sin(a), cos(a)) * l
	dir = Vector2(sin(a), cos(a))
	
func start_linear():
	set_linear()
	set_position(start_pos)
	set_angle()
	speed = BASE_SPEED
	thrown = 0
	
func set_linear():
	rotating = false
	$shape.set_deferred("disabled", false)
	$shape_circle.set_deferred("disabled", true)
	
func start_rotation():
	set_rotate()
	thrown = 2
	
func set_rotate():
	rotating = true
	$shape.set_deferred("disabled", true)
	$shape_circle.set_deferred("disabled", false)

func start_delay(time):
	$timer.wait_time = time
	$timer.start()

func set_angle():
	$sprite.rotation = dir.angle() - PI / 2
	$shape.rotation = $sprite.rotation
	
func reset():
	set_linear()
	position.y = - 50
	thrown = - 1
	$sprite.modulate = Color(1, 1, 1, 1)

func _process(_d):
	match thrown:
		0:
			set_position(position + _d * speed * dir)
			speed *= speed_factor
			if position.y > 138:
				thrown = 1
				$shape.disabled = true
				$disappear.interpolate_property($sprite, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
				$disappear.start()
		2:
			$sprite.rotate(rotate_speed * _d)
			set_position(position + dir * _d)
			dir.y += gl.gravity * 0.7
			if position.y > 148:
				swordgen.add_sword(position.x, $sprite.rotation)
				reset()

func _on_disappear_tween_completed(object, key):
	reset()
