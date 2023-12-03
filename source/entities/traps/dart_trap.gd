extends StaticBody2D

@onready var detection := $DetectionArea
@export var dart : PackedScene
@onready var player = get_tree().get_root().get_node("MainScene/Player") as Player
@onready var outlet = $Outlet
@onready var timer = $Timer

var is_active := false

func shoot():
	var dart_instance = dart.instantiate()
	dart_instance.position = outlet.global_position
	dart_instance.rotation = global_rotation
	get_tree().root.add_child(dart_instance)

func _on_detection_area_body_entered(body):
	if (body.name == "Player"):
		timer.start()
		shoot()
		is_active = true

func _on_detection_area_body_exited(body):
	if (body.name == "Player"):
		timer.stop()
		is_active = false

func _on_timer_timeout():
	print("timer end")
	if is_active:
		shoot()
