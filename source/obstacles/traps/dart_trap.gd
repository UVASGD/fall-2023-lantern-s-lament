extends Area2D

#@onready var trigger = get_node("Dart Trigger")

func area_entered(area):
	print(area)
	# check area group

func body_entered(body):
	print(body)
