extends Area2D

@export var speed := 500.0
@onready var player = get_tree().get_root().get_node("MainScene/Player") as Player
var damage : float = 1.0

func _physics_process(delta):
	position += transform.x * speed * delta



func _on_body_entered(body):
	if body.name == "Player":
		player.receive_damage(damage)
		queue_free()
