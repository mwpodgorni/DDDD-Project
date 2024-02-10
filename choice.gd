extends Node2D
var scene_to_load:String
onready var sprites = [$sprite, $sprite2]
onready var paths = ["res://postjam/postjam.tscn", "res://LD46/LD46.tscn"]
var active = true

func _process(delta):
	get_tree().change_scene(paths[1])
	if active:
		if Input.is_action_just_pressed("ui_left"):
			load_next_scene(0)
			active = false
		elif Input.is_action_just_pressed("ui_right"):
			load_next_scene(1)
			active = false
func load_next_scene(n):
	scene_to_load = paths[n]
	$timer.start()
	$tween.interpolate_property(sprites[n].get_material(), "shader_param/white_amount", 1.0, 0.0, 0.6, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$tween.start()
	
func _on_timer_timeout():
	get_tree().change_scene(scene_to_load)
