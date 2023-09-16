extends HitboxClass
class_name ProjBase

@onready var lifespan = $Lifespan

@onready var proj_owner #tower that spawned the projectile

@onready var speed : int = 200
@onready var range : int = 200
@onready var pierce : int = 1 #number of enemies a projectile can hit before despawning
@onready var homing : float = 0 #a multiple of PI in how much the projectile tries to chase enemies
@onready var persist : bool = false #if true, the projectile acts as if it has infinite pierce
@onready var follow : bool = false #if true, the projectile matches the tower's rotation while it exists
@onready var grow : bool = false #if true, the projectile grows in size over its lifespan. used for sweeper ping proj mostly

@onready var spawn_point #position where the projectile spawns, centered on the shooter's shooter_position

func _ready():
	z_index = 8
	if proj_owner:
		spawn_point = proj_owner.shooter_pos.global_position
	else:
		spawn_point = global_position

func destroy():
	queue_free()

func decay():
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.25)
	await tween.finished
	queue_free()

func _on_area_entered(area):
	if !persist:
		pierce -= 1
	if pierce == 0:
		destroy()

func looker(aim_pos, delta):
	var v = aim_pos - global_position
	var angle_to = transform.x.angle_to(v)
	rotate(sign(angle_to) * min(delta * (homing * PI), abs(angle_to)))

func destroy_in_secs(secs):
	lifespan.wait_time = secs
	lifespan.start()
	await lifespan.timeout
	decay()

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	
	if follow:
		global_position = proj_owner.shooter_pos.global_position
		rotation = proj_owner.rotation
	else:
		global_position += speed * direction * delta
		
	if grow:
		scale += Vector2(PI / 50, PI / 50)
	
	if homing > 0 and proj_owner.tower_owner.target != null:
		looker(proj_owner.tower_owner.target_pos, delta)
	
	if global_position.distance_to(spawn_point) > range:
		decay()
