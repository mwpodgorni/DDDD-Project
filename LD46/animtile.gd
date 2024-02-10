extends TileMap
var rects = [
	Rect2(128, 16, 16, 16), 
	Rect2(48, 32, 16, 16), 
	Rect2(48, 16, 16, 16), 
]
var rect = 0
var time = 0
func _process(d):
	time = (time + d)
	if time > 0.4:
		time = 0
		rect += 1
		if rect > rects.size() - 1:
			rect = 0
	tile_set.tile_set_region(7, rects[rect])
