extends Sprite

var pos = []
var angles = []
var s = Vector2(1, 1)
var r = Rect2( - 5, - 8, 10, 16)
var offsetval = Vector2(0, 0)

func _ready():
	for i in range(0, 30):
		add_sword(rand_range(0, 280) + 20, PI * randf())
	add_sword(20, PI / 5)
	add_sword(20, PI / 5)
	add_sword(20, PI / 5)

func _process(_d):
	update()

func add_sword(x, a):
	pos.push_back(Vector2(x, 148 + randi() % 3 - 1))
	angles.push_back(a)
	
func _draw():
	for i in range(0, pos.size()):
		draw_set_transform(pos[i] + offsetval, angles[i], s)
		draw_texture_rect_region(texture, r, Rect2(83, 0, 10, 16))
