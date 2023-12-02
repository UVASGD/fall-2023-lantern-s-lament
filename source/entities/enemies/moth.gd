extends EnemyBase

@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var dir : Vector2 = Vector2.ZERO
@export var tetherCords : Vector2 = Vector2.ZERO
@export var range : float = 2000.0
@onready var randomCords : Vector2 = Vector2.ZERO

func _ready():
	speed = 100
	hitbox.damage = 15
	max_hp = 40
	nav_agent.target_position = player.global_position
	super._ready()

func _physics_process(delta):
	super._physics_process(delta)
	dir = to_local(nav_agent.get_next_path_position()).normalized()
	move(speed * dir)

func _on_timer_timeout():
	if(enemy_in_area()):
		nav_agent.target_position = player.global_position
	elif(self.global_position.distance_to(tetherCords) >= range):
		nav_agent.target_position = tetherCords
	else:
		if(self.global_position.distance_to(randomCords) <= 100):
			randomCords = self.global_position + Vector2(400*(randf()-0.5), 400*(randf()-0.5))
		nav_agent.target_position = randomCords
