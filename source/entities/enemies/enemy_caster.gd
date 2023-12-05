extends EnemyBase

@onready var light = $PointLight2D
@onready var sight_range: int = 700
@onready var cooldown: int = 200
@onready var projectile = preload("res://source/entities/enemies/projectile_caster.tscn")
@onready var dir : Vector2 = Vector2.ZERO
@onready var distance : float
@onready var frame : int = 0
@onready var frame_x : int = 0
@onready var frame_y : int = 0
@onready var cast = $Cast

func _ready():
	super._ready()
	hitbox.damage = 50

func _physics_process(delta):
	distance = player.global_position.distance_to(global_position)
	cooldown -= delta
	if (distance < sight_range && cooldown <= 0):
		cast_projectile()
	
func cast_projectile():
	cooldown = 200
	var vector = Vector2(global_position.x + 16 * signf(dir.x), global_position.y - 172)
	cast.play()
	var projectile_inst = projectile.instantiate()
	projectile_inst.init(((player.global_position - vector).normalized()))
	get_tree().current_scene.add_child(projectile_inst)
	projectile_inst.global_position = vector
	projectile_inst.target_pos = ((player.global_position - vector).normalized())
	#print("Caster would cast projectile now")

func _on_animation_timer_timeout():
	dir = (player.global_position - global_position).normalized()
	if(dir.x > 0): frame_y = 0
	else: frame_y = 1
	if(distance < sight_range): frame_x = 2
	else: frame_x = 0
	frame = frame_x + 4*frame_y
	if(sprite.frame % 2 == 0): frame += 1
	sprite.frame = frame
	light.global_position.x = global_position.x + 16.0 * sign(dir.x)
	
