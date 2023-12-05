extends StaticBody2D

@onready var hitbox = $Hitbox
@onready var collider = $Hitbox/CollisionShape2D
@onready var detector = $Detector/CollisionShape2D
@onready var sprite = $Sprite2D
@onready var timer = $Timer
@onready var playerOver = false
@onready var timer_running = false
@export var auto_cycle : bool = false
@export var timer_waitTime : float = 1

func _ready():
	hitbox.damage = 3
	timer.connect("timeout", spike_cycle)
	timer.wait_time = timer_waitTime
	
	if auto_cycle:
		timer.start()

func spike_cycle():
	if collider.disabled:
		collider.disabled = false
		sprite.frame = 2
	else: 
		collider.disabled = true
		sprite.frame = 0

func _process(_delta):
	if(!auto_cycle):
		if playerOver and not timer_running:
			sprite.frame = 2
			timer.start()
			timer_running = true
		if(!playerOver):
			collider.disabled = false
			sprite.frame = 0
			timer.stop()
			timer_running = false

func _on_detector_area_entered(_area):
	playerOver = true

func _on_detector_area_exited(_area):
	playerOver = false
