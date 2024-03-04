extends KinematicBody2D
onready var g = get_node("/root/g")
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
var time = 0

func _ready():
	g.lost = 0
	g.completed = false
	$cooldown.connect("timeout", self, "_on_cooldown_end")
var can_hit = true
func _on_cooldown_end():
	can_hit = true

func flip():
	if not get_node("slash0/sprite").visible:
		$sprite.flip_h = true
		get_node("slash0").scale.x = - 1
		
	
func unflip():
	if not get_node("slash0/sprite").visible:
		$sprite.flip_h = false
		get_node("slash0").scale.x = 1
				
var mute = false
func _process(_d):
	if Input.is_action_just_pressed("ui_mute"):
		mute = not mute
		AudioServer.set_bus_mute(0, mute)
	if g.lost == 0:
		state_normal(_d)
	elif not g.completed:
		vel.x = 0
		if g.lost == 1:
			$anim.play("dieflower")
			g.completed = true
		elif g.lost == 2:
			$anim.play("die")
			g.completed = true
		elif g.lost == 3:
			$anim.play("dead")
			g.completed = true
	if Input.is_action_just_pressed("ui_reload"):
		gl.score=0
		gl.health=3
		gl.flowerHealth=4
		get_tree().reload_current_scene()
	vel.y += g.gravity
	position += (_d * vel)
	if position.y > 136:
		position.y = 136
		vel.y = 0
		can_jump = true
	if gl.health > 0 && time >= 1:
		time = 0
		gl.score += 2
	time += _d
	
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
	print("Sword hit")
	if body.hitting:
		$sparks.position = body.position - position
		$sparks.rotation = $sparks.position.angle() - PI / 2
		get_node("sparks/anim").play("spark")
		body.hit($sparks.position.normalized())
		gl.score+=100

func _on_got_hit(area):
	print("Got hit")
	get_node("../sound/hurt").play()
	hits = clamp(hits + 1, 0, MAX_HITS - 1)
	gl.health = MAX_HITS-1-hits
	area.reset()
	swords[hits].visible = true
	if hits == MAX_HITS - 1 and not g.completed:
		g.lost = 2
		die()
		
func die():
	$hit.set_deferred("monitoring", false)
	vel.x = 0
