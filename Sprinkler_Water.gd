extends StaticBody2D

@onready var Sprinklertrap = $SprinklerWater

func _physics_process(delta):
	Sprinklertrap.rotate(.1)

