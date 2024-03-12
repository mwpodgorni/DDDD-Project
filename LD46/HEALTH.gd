extends Label

func _process(delta):
	self.text = str(gl.health)
	if(gl.health < 2): self.modulate = Color(255, 0, 0, 1)
