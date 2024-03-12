extends Node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(gl.flowerHealth <= 3): 
		for x in get_node("Flower4").get_children():
			x.visible = false;
	
	if(gl.flowerHealth <= 2):
		for x in get_node("Flower3").get_children():
			x.visible = false;
	
	if(gl.flowerHealth <= 1):
		for x in get_node("Flower2").get_children():
			x.visible = false;

	if(gl.flowerHealth <= 0): 
		for x in get_node("Flower").get_children():
			x.visible = false;

