extends Area2D

@onready var sprite = $Sprite2D
@onready var lit = false
@onready var torches_lit = false
@onready var player = get_tree().get_root().get_node("MainScene/Player")

@onready var monster : PackedScene = preload("res://source/entities/enemies/eol_monster.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	if !lit:
		torches_lit = true
		get_tree().call_group("torches", "are_lit")
		if torches_lit:
			lit = true
			sprite.frame += 1
			var monster_inst = monster.instantiate()
			get_tree().current_scene.add_child(monster_inst)
			monster_inst.scale = Vector2(15, 15)
			monster_inst.global_position = self.global_position - 2*player.speed

"""
func light():
	#torches_lit += 1
	pass
"""
