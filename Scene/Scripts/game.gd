extends Node2D


@export var enemy_scenes: Array[PackedScene] = []


@onready var playerSpawnPosition = $PlayerSpawnPos
@onready var laser_container = $LaserContainer
@onready var enemy_container = $EnemyContainer
@onready var Enemy_spawnTimer = $EnemySpawnTimer
@onready var hud = $UILayer/HUD
@onready var gos = $UILayer/GameOver

var player = null
var score := 0:
	set(value):
		score = value
		hud.score = score
var high_score

func _ready():
	var save_file = FileAccess.open("user://sava.data", FileAccess.READ)
	if save_file != null:
		high_score = save_file.get_32()
	else:
		high_score = 0 
		save_game()
	score = 0
	player = get_tree().get_first_node_in_group("Player")
	assert(player!=null)
	player.global_position = playerSpawnPosition.global_position
	player.laser_shot.connect(on_player_laser_shot)
	player.killed.connect(on_player_killed)
	
func save_game():
	var save_file = FileAccess.open("user://sava.data", FileAccess.WRITE)
	save_file.store_32(high_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.func _process(delta):
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
	e.killed.connect(on_enemy_killed)
	enemy_container.add_child(e)
	
func on_enemy_killed(points):
	score += points
	if score > high_score:
		high_score = score
	
func on_player_killed():
	gos.set_score(score) 
	gos.set_high_Score(high_score)
	save_game()
	await get_tree().create_timer(1.5).timeout
	gos.visible = true
	
