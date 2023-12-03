extends HitboxClass


# Called when the node enters the scene tree for the first time.
func _ready():
	damage = 10;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation += delta * 2;
	pass
