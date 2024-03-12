extends Node

func _process(delta):
	if(gl.health <= 2): get_node("Heart3").visible = false
	if(gl.health <= 1): get_node("Heart2").visible = false
	if(gl.health <= 0): get_node("Heart").visible = false
