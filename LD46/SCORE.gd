extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var wave = get_parent().get_parent().get_node("swordplayer").currentWave();
	var maxWave = get_parent().get_parent().get_node("swordplayer").maxWave();
	self.text = str(wave) + "/" + str(maxWave)
