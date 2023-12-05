extends StaticBody2D

@onready var sprite = $Sprite2D
@onready var hitbox = $Hitbox
@onready var speed = 300
@onready var target_pos

func _ready():
	hitbox.damage = 10

func _physics_process(delta):
	if (target_pos != null):
		global_position += target_pos * speed * delta
		#global_position = Vector2(global_position.x + target_pos.x * speed * delta, global_position.y + target_pos.y * speed * delta)
		
func init(target_vector):
	#hitbox.damage = 10
	target_pos = target_vector
	speed = 300

func _on_animation_timer_timeout():
	if(target_pos.x < 0): sprite.flip_h = true
	else: sprite.flip_h = false
	if(sprite.frame == 0): sprite.frame = 1
	else: sprite.frame = 0
