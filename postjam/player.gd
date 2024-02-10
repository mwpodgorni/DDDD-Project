extends KinematicBody2D
onready var gl = get_node("/root/gl")
onready var swords = [get_node("s/swordhit0"), get_node("s/swordhit1"), get_node("s/swordhit2")]
var hits = - 1
const MAX_HITS = 3
var speed = 10
const MAX_SPEED = 70
var vel = Vector2(0, 0)
var mu = 0.05
var keys = [0, 0, 0, 0]
var jump = 0
var jumping = false
var jump_base = 50
var can_jump = false
var mute = true
var can_hit = true

func _ready():
	gl.lost = 0
	gl.completed = false
	$cooldown.connect("timeout", self, "_on_cooldown_end")
	AudioServer.set_bus_mute(0, mute)
func _on_cooldown_end():
	can_hit = true

func flip():
	if not get_node("slash0/sprite").visible:
		$sprite.flip_h = true
		get_node("slash0").scale.x = - 1
		$s.position.y = 0
		
	
func unflip():
	if not get_node("slash0/sprite").visible:
		$sprite.flip_h = false
		get_node("slash0").scale.x = 1
		$s.position.y = 0
				
				
func _process(_d):
	if Input.is_action_just_pressed("ui_mute"):
		mute = not mute
		AudioServer.set_bus_mute(0, mute)
	if gl.lost == 0:
		state_normal(_d)
	elif not gl.completed:
		vel.x = 0
		if gl.lost == 1:
			$anim.play("dieflower")
			gl.completed = true
		elif gl.lost == 2:
			$anim.play("die")
			gl.completed = true
		elif gl.lost == 3:
			$anim.play("dead")
			gl.completed = true
	if Input.is_action_just_pressed("ui_reload"):
		get_tree().reload_current_scene()
	vel.y += gl.gravity
	position += (_d * vel)
	if position.y > 136:
		position.y = 136
		vel.y = 0
		can_jump = true
	
func state_normal(_d):
	keys = [0, 0, 0, 0]
	var factor = 1
	var air_mu = 1
	if Input.is_action_pressed("ui_run"):
		factor = 2
	if not can_jump:
		air_mu = 0.4
	if Input.is_action_pressed("ui_left"):
		vel.x -= speed * air_mu
		keys[2] = 1
		unflip()
	if Input.is_action_pressed("ui_right"):
		vel.x += speed * air_mu
		keys[0] = 1
		flip()
	if Input.is_action_just_pressed("ui_accept") and can_jump:
		jump = jump_base
		jumping = true
		can_jump = false
	if jumping:
		if Input.is_action_pressed("ui_accept"):
			vel.y -= jump
			jump *= 0.8
			if jump < 5:
				jump = 0
				jumping = false
		else :
			jumping = false

	if not keys[0] and not keys[2]:
		vel.x *= mu
	vel.x = clamp(vel.x, - MAX_SPEED * factor, MAX_SPEED * factor)
	if abs(vel.x) < 0.5:
		vel.x = 0
	if not can_jump:
		$anim.play("jump")
	elif vel.x != 0:
		$anim.play("run")
	else :
		$anim.play("still")
	

	
	if can_hit and Input.is_action_just_pressed("ui_hit"):
		can_hit = false
		$slash0.attack()
		$cooldown.start()


func _on_sword_hit(body):
	if body.thrown != - 1:
		$sparks.position = body.position - position
		$sparks.rotation = $sparks.position.angle() - PI / 2
		get_node("sparks/anim").play("spark")
		body.hit($sparks.position.normalized())

func _on_got_hit(area):
	get_node("../sound/hurt").play()
	hits = clamp(hits + 1, 0, MAX_HITS - 1)
	area.reset()
	swords[hits].visible = true
	if hits == MAX_HITS - 1 and not g.completed:
		gl.lost = 2
		die()
		
func die():
	$hit.set_deferred("monitoring", false)
	vel.x = 0
