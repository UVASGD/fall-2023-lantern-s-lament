extends StaticBody2D

@onready var trigger := $CollisionShape2D/trigger_area
@export var dart : PackedScene
@onready var outlet := $outlet

var is_active := false

func _physics_process(delta):
	pass

func shoot():
	var dart_instance := dart.instantiate()
	get_tree().root.add_child(dart_instance)
	dart_instance.position = outlet.position + global_position + Vector2(-50, 0)
	dart_instance.rotation = global_rotation

func _on_trigger_area_body_entered(body):
	if (body.name == "Player"):
		shoot()
		is_active = true

func _on_trigger_area_body_exited(body):
	is_active = false
