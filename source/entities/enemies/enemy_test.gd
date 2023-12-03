extends EnemyBase

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var dir : Vector2 = Vector2.ZERO
@export var tetherCords : Vector2 = Vector2.ZERO
@onready var range : float = 1000
@onready var randomCords : Vector2 = Vector2.ZERO
@onready var frame : int = 0
@onready var frame_x : int = 0
@onready var frame_y : int = 0

func _ready():
	speed = 100
	hitbox.damage = 15
	max_hp = 40
	nav_agent.target_position = player.global_position
	randomCords = tetherCords + Vector2(400*(randf()-0.5), 400*(randf()-0.5))
	super._ready()

func _physics_process(delta):
	dir = to_local(nav_agent.get_next_path_position()).normalized()
	move(speed * dir)

func _on_timer_timeout():
	if(self.global_position.distance_to(player.global_position) <= range): 
		nav_agent.target_position = player.global_position
	elif(self.global_position.distance_to(tetherCords) >= range):
		nav_agent.target_position = tetherCords
	else:
		if(self.global_position.distance_to(randomCords) <= 100):
			randomCords = self.global_position + Vector2(400*(randf()-0.5), 400*(randf()-0.5))
		nav_agent.target_position = randomCords
	
func _on_animation_timer_timeout():
	if(dir.x > 0): frame_y = 0
	else: frame_y = 1
	if(nav_agent.target_position == player.global_position): frame_x = 2
	else: frame_x = 0
	frame = frame_x + 4*frame_y
	if(sprite.frame % 2 == 0): frame += 1
	sprite.frame = frame
