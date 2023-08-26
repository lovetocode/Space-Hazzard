extends Node2D

var player = null
@onready var playerSpawnPosition = $PlayerSpawnPos

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	assert(player!=null)
	player.global_position = playerSpawnPosition.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
