extends EntityBase
class_name EnemyBase

@onready var hitbox = $Hitbox

@onready var speed : int = 100

@onready var target_pos
@onready var in_aim_area : bool = false

func _ready():
	super._ready()
	self.z_index = 2
	self.scale = Vector2(2, 2)

func _physics_process(_delta):
	in_aim_area = enemy_in_area()
	
	target_pos = (player.global_position - global_position).normalized()
	super.move(target_pos * speed)

func die():
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.25)
	await tween.finished
	super.die()

func _on_hurtbox_area_entered(area):
	if area.DOT > Vector2(0, 0):
		take_DOT(area.DOT.x, area.DOT.y)
	receive_damage(area.damage)

func take_DOT(dmg : int, duration : int):
	for x in range(duration):
		await get_tree().create_timer(1.0).timeout
		receive_damage(dmg)

func angle_in_range(alpha, lower, upper):
	alpha = int(alpha) % 360
	lower = int(lower) % 360
	upper = int(upper) % 360
	if lower > upper:
		return alpha >= lower or alpha <= upper
	return alpha > lower and alpha < upper

func enemy_in_area():
	var upper_angle : float = rad_to_deg(atan2(player.man_aim_left.y - player.CENTER.y, player.man_aim_left.x - player.CENTER.x))
	var lower_angle : float = rad_to_deg(atan2(player.man_aim_right.y - player.CENTER.y, player.man_aim_right.x - player.CENTER.x))
	
	var angle = rad_to_deg(atan2(global_position.y - player.CENTER.y, global_position.x - player.CENTER.x))
	var distance_to_hull = (global_position.distance_to(player.CENTER))
	
	return angle_in_range(angle, lower_angle + 1, upper_angle - 1) and distance_to_hull <= player.man_cur_range
