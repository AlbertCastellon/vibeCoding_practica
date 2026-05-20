extends Node3D

@export var player: Node3D

var offset := Vector3(0, 3, 8)

func _process(delta):
	if player:
		position.z = player.position.z + offset.z
