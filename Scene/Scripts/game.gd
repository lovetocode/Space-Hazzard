extends Node2D

var player = null
@onready var playerSpawnPosition = $PlayerSpawnPos
@onready var laser_container = $LaserContainer

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	assert(player!=null)
	player.global_position = playerSpawnPosition.global_position
	player.laser_shot.connect(on_player_laser_shot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		
func on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
	
