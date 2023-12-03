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

func enemy_in_area():
	var upper_angle : float = player.man_aim_angle + (PI - player.move_angle)
	if upper_angle > (2*PI): upper_angle = upper_angle - (2*PI) #corrects values to keep them within 0-2pi
	var lower_angle : float = player.man_aim_angle - (PI - player.move_angle)
	if lower_angle < 0: lower_angle = lower_angle + (2*PI) #corrects values to keep them within 0-2pi
	
	var angle = atan2(-(global_position.y - player.global_position.y), global_position.x - player.global_position.x)
	angle = angle + (PI/2) #makes angle of enemy and man_aim_angle measured from the same point (positive y axis)
	if angle < 0: angle = angle + (2*PI) #corrects values to keep them within 0-2pi
	var distance_to_hull = (global_position.distance_to(player.global_position))
	
	#print(str(upper_angle) + " " + str(lower_angle) + " " + str(angle) + " " + str(distance_to_hull))
	#print(str(global_position.y) + " " +  str(player.global_position.y) + " " + str(global_position.x) + " " +  str(player.global_position.x))
	if distance_to_hull <= player.man_cur_range:
		if !Input.is_action_pressed("space_bar"): #for when the lantern is unfocused
			return true
		if lower_angle > upper_angle: #for when the lantern is asfocused
			return angle >= lower_angle or angle <= upper_angle
		return angle > lower_angle and angle < upper_angle
	return false
