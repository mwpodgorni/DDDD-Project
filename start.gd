extends Node2D
var scene_to_load:String
onready var path = "res://LD46/LD46.tscn"
var active = true

func _process(delta):
	if active:
		# if input is SPACE (because SPACE is being used for the action "ui_select")
		if Input.is_action_just_pressed("ui_select"):
			get_tree().change_scene(path)
			active = false
func load_next_scene():
	scene_to_load = path
	$timer.start()
	$tween.start()
	
func _on_timer_timeout():
	get_tree().change_scene(scene_to_load)
