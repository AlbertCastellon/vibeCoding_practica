extends Node3D

@export var obstacle_scene: PackedScene
@export var player: Node3D

var spawn_distance := 40.0
var lane_width := 2.0

var spawn_timer := 0.0
var spawn_interval := 2.0

func _process(delta):

	if player == null:
		return

	spawn_timer += delta

	if spawn_timer >= spawn_interval:

		spawn_timer = 0.0
		spawn_obstacle()

func spawn_obstacle():

	var obstacle = obstacle_scene.instantiate()

	var lane = randi_range(-1, 1)

	obstacle.position.x = lane * lane_width
	obstacle.position.y = 1.5
	obstacle.position.z = player.position.z - spawn_distance

	get_parent().add_child(obstacle)
