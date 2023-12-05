extends Area2D

@onready var player = get_parent().get_node("Player")
@onready var sprite = $Sprite2D
@onready var hitbox = $CollisionShape2D
@onready var speed = 5
@onready var damage = 50
@onready var boost = 0
@onready var dir : Vector2 = Vector2.ZERO
@onready var frame : int = 0
@onready var frame_x : int = 0
@onready var frame_y : int = 0

func _ready():
	pass

func _physics_process(delta):
	dir = (player.global_position - global_position).normalized()
	if(!player.has_died): global_position += dir * (speed + boost) 
	boost *= 0.95
	
	match frame_y:
		0:
			hitbox.position = Vector2(0, -30)
			hitbox.scale = Vector2(1.5, 2)
		1:
			hitbox.position = Vector2.ZERO
			hitbox.scale = Vector2(5, 2)
		2:
			hitbox.position = Vector2(0, -60)
			hitbox.scale = Vector2(1.5, 2.5)
		3:
			hitbox.position = Vector2.ZERO
			hitbox.scale = Vector2(5, 2)

func _on_area_entered(_area):
	print("entered")
	boost = -25

func _on_animation_timer_timeout():
	if(abs(dir.x) > 0.5):
		if(dir.x > 0): frame_y = 1
		else: frame_y = 3
	else:
		if(dir.y > 0): frame_y = 0
		else: frame_y = 2
	if(frame_x >= 3): frame_x = 0
	frame = frame_x + 3*frame_y
	sprite.frame = frame
	frame_x += 1
