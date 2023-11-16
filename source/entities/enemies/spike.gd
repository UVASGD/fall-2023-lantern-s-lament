extends StaticBody2D

@onready var hitbox = $Hitbox
@onready var collider = $Hitbox/CollisionShape2D
@onready var sprite = $Sprite2D
@onready var playerOver = false
@onready var timer_running = false
@onready var spikes_down = load("res://assets/Spikes down.png")
@onready var spikes_up = load("res://assets/Spikes up.png")
@onready var spikesActive = true

@export var cycleDuration = 0 #set to 0 if you don't want it

# Called when the node enters the scene tree for the first time.
func _ready():
	hitbox.damage = 5
	
	#create a cycling spikes if we want that
	if cycleDuration != 0:
		var timer = Timer.new()
		timer.set_wait_time(cycleDuration)
		timer.set_one_shot(false)
		timer.connect("timeout", spike_cycle)
		add_child(timer)
		timer.start()

func spike_cycle():
	if spikesActive:
		collider.disabled = true
		sprite.texture = spikes_down
		spikesActive = false
	else:
		collider.disabled = false
		sprite.texture = spikes_up
		spikesActive = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playerOver and not timer_running:
		timer_running = true
		collider.disabled = true
		await get_tree().create_timer(1.0).timeout
		timer_running = false
		if spikesActive:
			collider.disabled = false
	
	


func _on_hitbox_area_entered(area):
	#assuming the only thing that overlaps is the player
	#if area.is_in_group("player"):
	playerOver = true

func _on_hitbox_area_exited(area):
	#assuming the only thing that overlaps is the player
	#if area.is_in_group("player"):
	playerOver = false
