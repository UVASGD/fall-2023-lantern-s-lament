extends EntityBase
class_name TowerHull

@onready var hitbox = $Hitbox
@onready var camera = $Camera2D
@onready var light_occluder = $LightOccluder2D
@onready var point_light = $PointLight2D

@onready var side_menu = get_tree().get_root().get_node("MainScene/Menu/SideMenu")

#ALL AIMING RELATED VARIABLES
const CENTER = Vector2(0.0, 0.0)
@onready var man_aim_angle : float = PI #this gets it to start facing upward
@onready var man_aim_pos : Vector2 = CENTER
@onready var man_aim_left : Vector2 = CENTER #new coords to the left
@onready var man_aim_right : Vector2 = CENTER #new coords to the right
@onready var man_max_width : float = 30 / 100.0 #max width of manual aim. this starts low but can be increased through upgrades
@onready var man_cur_width : float = man_max_width  #padding on each side to determine width of wide aim

@onready var man_aim_back : Vector2 = CENTER

@onready var man_base_range : float = 400
@onready var man_cur_range : float = 0 #the range that man aim stretches out to. set this to the highest range of your towers
@onready var man_max_range : float = 1000

@onready var move_angle : float = 0
@onready var back_angle : float = man_aim_angle + PI
@onready var turn_rate : float = 1.5

#GAME STATE AND PLAYER STATS
@onready var game_start : bool = false

@onready var speed : Vector2  = Vector2(0, 0)

#CAMERA VARIABLES
@onready var max_zoom : Vector2 = Vector2(0.5, 0.5) #0.4
@onready var min_zoom : Vector2 = Vector2(0.25, 0.25)
@onready var cur_zoom : Vector2 = max_zoom

@onready var shake_strength : int = 0 #strength of camera shake on taking damage, initialized to 0.0

#LIGHT VARIABLES
@onready var point_light_scale : float = 0.0 #the size of the point light
@onready var point_light_offset : float = 0.0

func _ready():
	setup_stats()
	game_start = true

func _physics_process(delta):
	back_angle = man_aim_angle + PI
	
	queue_redraw()
	
	if Input.is_action_pressed("move_up") and !Input.is_action_pressed("move_down"):
		speed += Vector2(0, -50)
	elif Input.is_action_pressed("move_down") and !Input.is_action_pressed("move_up"):
		speed += Vector2(0, 50)

	speed *= 0.9
	move(speed)

	if Input.is_action_pressed("rotate_left") and !Input.is_action_pressed("rotate_right"):
		speed += Vector2(-50, 0)
	elif Input.is_action_pressed("rotate_right") and !Input.is_action_pressed("rotate_left"):
		speed += Vector2(50, 0)

	looker2(get_global_mouse_position(), delta)

	man_aim_pos = Vector2(sin(man_aim_angle) * man_cur_range, cos(man_aim_angle) * man_cur_range)
	man_aim_left = Vector2(sin(back_angle + move_angle) * man_cur_range, cos(back_angle + move_angle) * man_cur_range)
	man_aim_right = Vector2(sin(back_angle - move_angle) * man_cur_range, cos(back_angle - move_angle) * man_cur_range)
	
	man_aim_back = Vector2(sin(back_angle) * man_cur_range, cos(back_angle) * man_cur_range)
	
	if Input.is_action_pressed("space_bar"):
		var tween = create_tween()
		var tween2 = create_tween()
		var tween3 = create_tween()
		var tween4 = create_tween()
		var tween5 = create_tween()
		tween.tween_property(self, "move_angle", PI - man_max_width, 0.3)
		tween.tween_property(self, "man_cur_range", man_max_range, 0.1)
		tween2.tween_property(self, "cur_zoom", min_zoom, 0.4)
		tween3.tween_property(self, "turn_rate", 1.0, 0.4)
		tween4.tween_property(self, "point_light_scale", 20, 0.4)
		tween5.tween_property(self, "point_light_offset", 75.0, 0.4)
	else:
		var tween = create_tween()
		var tween2 = create_tween()
		var tween3 = create_tween()
		var tween4 = create_tween()
		var tween5 = create_tween()
		tween.tween_property(self, "man_cur_range", man_base_range, 0.2)
		tween.tween_property(self, "move_angle", 0, 0.3)
		tween2.tween_property(self, "cur_zoom", max_zoom, 0.4)
		tween3.tween_property(self, "turn_rate", 1.5, 0.4)
		tween4.tween_property(self, "point_light_scale", 8, 0.4)
		tween5.tween_property(self, "point_light_offset", 0.0, 0.4)
	
	shake_strength = lerp(shake_strength, 0, 5.0 * delta) #delta is multiplied by decay rate of shake, set to 5.0 for now
	
	camera.zoom = cur_zoom
	camera.offset.x = snapped((-128 + randi_range(-shake_strength, shake_strength)) / camera.zoom.x, .1)
	camera.offset.y = randi_range(-shake_strength, shake_strength)
	
	point_light.global_position = global_position + Vector2(sin(man_aim_angle) * point_light_offset, cos(man_aim_angle) * point_light_offset)
	point_light.texture_scale = point_light_scale

func _input(event):
	if game_start and event.is_action_pressed("pause_menu"):
		side_menu.pause_game()

func looker(angle, delta):
	var angle_to = transform.x.angle_to(Vector2(sin(angle), cos(angle)))
	man_aim_angle -= (sign(angle_to) * min(delta * (PI), abs(angle_to)))

func looker2(target_pos, delta):
	var v = target_pos - global_position
	var angle_to = angle_to_angle(man_aim_angle, (v.angle() - PI/2) * -1)
	man_aim_angle += (sign(angle_to) * min(delta * clamp(PI * abs(angle_to), PI / 4, TAU), abs(angle_to)))

func angle_to_angle(from, to):
	return fposmod(to-from + PI, PI * 2) - PI

func setup_stats():
	z_index = 1
	max_hp = 100
	super._ready()
	hitbox.damage = 999
	global_position = CENTER
	hitbox.add_to_group("hull")

func receive_damage(base_damage : int):
	super.receive_damage(base_damage)
	shake_strength = clamp(base_damage / 2.0, 5, 25) #shakes the camera on taking damage

func die():
	print("game over")
	get_tree().paused = true

func _draw():
	const WHITE = Color(1, 1, 1, 1)
	const BLUE = Color(0, 0, 1, 1)
	const GRAY = Color(0.80, 0.80, 0.80, 1)
	const DGRAY = Color(0.20, 0.20, 0.20, 1)
	if man_aim_angle > TAU:
		man_aim_angle -= TAU
	elif man_aim_angle < 0:
		man_aim_angle += TAU

	back_angle = man_aim_angle + PI
	
#	draw_arc(CENTER, man_max_range / 2, -.025, TAU + .025, 40, DGRAY, man_max_range)
	
	#draw_arc(CENTER, man_cur_range / 2, (PI * 2.5) - (back_angle + move_angle - .025), (PI * 0.5) - man_aim_angle - .025, 40, WHITE, man_cur_range)
	#draw_arc(CENTER, man_cur_range / 2, (PI * 0.5) - man_aim_angle + .025, (PI * 0.5) - (back_angle - move_angle + .025), 40, WHITE, man_cur_range)
	
#	draw_line(CENTER, man_aim_left, BLUE)
#	draw_line(CENTER, man_aim_right, BLUE)

	draw_line(CENTER, man_aim_pos, WHITE) #draw aim angle line

	var x = Vector2(sin(back_angle) * 75, cos(back_angle) * 75)
	
	var y = Vector2(sin(back_angle + (move_angle/2)) * 200, cos(back_angle + (move_angle/2)) * 200)
	
	var occ_points = [CENTER, CENTER, CENTER]
	if(move_angle > 0.009):
		occ_points = [x, man_aim_right, CENTER, man_aim_left]
		
	light_occluder.occluder.polygon = occ_points
	#print(move_angle)
	#draw_colored_polygon(occ_points, BLUE)

#func _input(event):
#	if event is InputEventMouseButton:
#		if event.is_pressed():
#			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
#				pass
