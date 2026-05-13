extends Node3D

@export var player: Node3D

func _process(delta):
	if player:
		position.z = player.position.z
