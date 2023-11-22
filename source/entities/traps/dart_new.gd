extends HitboxClass

@export var speed := 1000.0

func _ready():
	damage = 25

func _physics_process(delta):
	position += transform.x * speed * delta
