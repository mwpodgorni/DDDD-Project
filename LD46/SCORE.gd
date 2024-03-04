extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	self.modulate = Color(255, 255, 255, 1)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.text = str(gl.score)
