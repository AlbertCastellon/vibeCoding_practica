extends CharacterBody3D

# --- Configuración ---
var lane_width := 2.0
var lane_index := 0   # -1 izquierda, 0 centro, 1 derecha
var target_x := 0.0

var forward_speed := 10.0
var lateral_speed := 10.0

# --- Física ---
var gravity := 20.0
var jump_force := 8.0
var is_dead := false

func _ready():
	target_x = position.x

func _physics_process(delta):

	if is_dead:
		return

	handle_input()
	apply_movement(delta)
	check_collision()
	
func handle_input():
	if Input.is_action_just_pressed("move_left"):
		lane_index -= 1
	if Input.is_action_just_pressed("move_right"):
		lane_index += 1

	lane_index = clamp(lane_index, -1, 1)
	target_x = lane_index * lane_width

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force

func apply_movement(delta):
	# Movimiento lateral suave
	var direction_x = target_x - position.x
	velocity.x = direction_x * lateral_speed

	# Movimiento hacia delante
	velocity.z = -forward_speed

	# Gravedad
	if not is_on_floor():
		velocity.y -= gravity * delta

	move_and_slide()
	
func check_collision():
	for i in get_slide_collision_count():

		var collision = get_slide_collision(i)

		if collision.get_collider().is_in_group("obstacle"):
			
			game_over()
			
func game_over():

	if is_dead:
		return

	is_dead = true

	print("GAME OVER")
