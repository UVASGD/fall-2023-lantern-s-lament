extends Area2D

@export var speed := 1000.0
@onready var player = get_tree().get_root().get_node("MainScene/Player") as Player
@onready var hitbox := $Hitbox

func _physics_process(delta):
	position += transform.x * speed * delta

func _ready():
	hitbox.damage = 99
