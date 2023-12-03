extends StaticBody2D

@onready var hitbox = $Hitbox
@onready var collider = $Hitbox/CollisionShape2D
@onready var sprite = $Sprite2D
@onready var timer = $Timer
@onready var playerOver = false
@onready var timer_running = false
@export var cycle : bool = false
@export var timer_waitTime : float = 1

func _ready():
	hitbox.damage = 5
	timer.connect("timeout", spike_cycle)
	timer.wait_time = timer_waitTime
	
	if cycle:
		timer.start()

func spike_cycle():
	print("cycle")
	if collider.disabled:
		collider.disabled = false
		sprite.frame = 2
	else: 
		collider.disabled = true
		sprite.frame = 0

func _process(_delta):
	if(!cycle):
		if playerOver and not timer_running:
			sprite.frame = 2
			timer.start()
			timer_running = true
		if(!playerOver && collider.disabled):
			collider.disabled = false
			timer.stop()
			timer_running = false

func _on_hitbox_area_entered(_area):
	#assuming the only thing that overlaps is the player
	#if area.is_in_group("player"):
	playerOver = true

func _on_hitbox_area_exited(_area):
	#assuming the only thing that overlaps is the player
	#if area.is_in_group("player"):
	playerOver = false
