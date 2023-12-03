extends StaticBody2D

@onready var detection := $DetectionArea
@export var dart : PackedScene
@onready var player = get_parent().get_node("Player")
@onready var outlet := $Outlet
@onready var timer := $Timer
@onready var bushSprite = $BushSprite
@onready var barrelSprite = $BarrelSprite

var is_active := false

func _ready():
	bushSprite.rotation = global_rotation * -1

func shoot() -> void:
	var dart_instance := dart.instantiate()
	dart_instance.position = outlet.global_position
	dart_instance.rotation = global_rotation
	get_tree().current_scene.add_child(dart_instance)

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
	if is_active:
		shoot()
