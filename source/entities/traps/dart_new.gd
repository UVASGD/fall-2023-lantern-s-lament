extends HitboxClass

@export var speed := 1000.0
@onready var spawn_point

func _ready():
	damage = 10
	spawn_point = global_position

func _physics_process(delta):
	position += transform.x * speed * delta
	if spawn_point.distance_to(global_position) > 2000:
		queue_free()
