extends EnemyBase

@onready var sight_range: int = 700
@onready var cooldown: int = 200
@onready var projectile = preload("res://source/entities/enemies/projectile_caster.tscn")

func _ready():
	super._ready()
	hitbox.damage = 50

func _physics_process(delta):
	super._physics_process(delta)
	var distance = player.global_position.distance_to(global_position)
	move(Vector2(0,0))
	cooldown -= delta
	if (distance < sight_range && cooldown <= 0):
		cast_projectile()
	
func cast_projectile():
	cooldown = 200
	var projectile_inst = projectile.instantiate()
	projectile_inst.init(((player.global_position - global_position).normalized()))
	get_tree().current_scene.add_child(projectile_inst)
	projectile_inst.global_position = Vector2(global_position.x, global_position.y)
	projectile_inst.target_pos = ((player.global_position - global_position).normalized())
