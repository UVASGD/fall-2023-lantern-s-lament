extends CharacterBody2D
class_name EntityBase

@onready var player = get_tree().get_root().get_node("MainScene/Player")

@onready var max_hp : int = 100
@onready var cur_hp : int = 0 : set = set_cur_hp
@onready var defense : int = 0
@onready var has_died : bool = false
@onready var invulnerable: bool = false
@onready var knock_back: bool = false
@onready var back_speed: Vector2 = Vector2(0, 0)

@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D
@onready var animation_player = $AnimationPlayer
@onready var hurtbox = $Hurtbox

func _ready():
	set_cur_hp(max_hp)

func move(vel):
	if !knock_back: set_velocity(vel)
	else:
		set_velocity(back_speed)
		back_speed *= 0.95
		if abs(back_speed.x) < 10 and abs(back_speed.y) < 10: knock_back = false
	move_and_slide()

func die():
	queue_free()

func receive_damage(base_damage : int):
	var actual_damage = base_damage - defense
	if !invulnerable:
		cur_hp -= actual_damage
		print(name + " received " + str(actual_damage) + " damage and has " + str(cur_hp) + " health remaining ")
		if base_damage == 0: 
			knock_back = true
			back_speed = player.direction*-750
		if cur_hp <= 0 and !has_died:
			print(name + " has died! ")
			has_died = true
			die()

func _on_hurtbox_area_entered(hitbox):
	receive_damage(hitbox.damage)

func set_cur_hp(value):
	if value != cur_hp:
		cur_hp = clamp(value, 0, max_hp)
		
