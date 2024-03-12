extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = str(gl.flowerHealth)
	if(gl.flowerHealth <= 2): self.modulate = Color(255, 0, 0, 1) 
