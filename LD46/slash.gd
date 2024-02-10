extends Area2D

func attack():
	$anim.seek(0)
	$anim.play("attack")
	monitoring = true
	
