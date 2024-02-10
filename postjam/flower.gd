extends Area2D
onready var gl = get_node("/root/gl")
onready var petals = [get_node("leaf0"), get_node("leaf1"), get_node("leaf2"), get_node("leaf3")]
var hit_petals = - 1
const PETALS = 4

func hit():
	hit_petals += 1;
	if hit_petals < PETALS:
		var tween = petals[hit_petals].get_node("tween")
		tween.interpolate_property(petals[hit_petals], "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
	if hit_petals >= PETALS - 1 and not gl.completed:
		gl.lost = 1
	
func _process(_d):
	pass

func _on_flower_area_entered(area):
		if area.is_in_group("swords"):
			hit()
