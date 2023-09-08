extends Node2D


@export var enemy_scenes: Array[PackedScene] = []

var player = null
@onready var playerSpawnPosition = $PlayerSpawnPos
@onready var laser_container = $LaserContainer
@onready var enemy_container = $EnemyContainer
@onready var Enemy_spawnTimer = $EnemySpawnTimer

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

func _on_enemy_spawn_timer_timeout():
	var e = enemy_scenes.pick_random().instantiate()
	e.global_position = Vector2(randf_range(50, 500), -5)
	enemy_container.add_child(e)
