extends Area2D

class_name DartTrap

@onready var player := get_tree().get_root().get_node("MainScene/Player") as Player
@export var dart : PackedScene
@onready var rotation_speed : float = PI/100

func _physics_process(delta: float) -> void:
#	var tween: Tween = create_tween()
#	tween.tween_method(look_at.bind(Vector2.DOWN), self.position, player.position, 1.0)
	rotate(rotation_speed)
	var dart_instance := dart.instantiate()
	get_tree().root.add_child(dart_instance)
	dart_instance.position = global_position + Vector2(-50, 0)
	dart_instance.rotation = global_rotation


func _on_body_entered(body):
		print("ran")
