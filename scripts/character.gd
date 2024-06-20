extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const HORIZONTAL_SENSITIVITY = 0.01
const VERTICAL_SENSITIVITY = 0.01

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var tilt = 0
@onready var head_transform = $Head.transform

@export var player_id: int = 1:
	set(id):
		player_id = id

func _ready():
	if player_id == multiplayer.get_unique_id():
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		$Head/Camera.current = true
	else:
		set_physics_process(false)
		set_process_input(false)
	
	if multiplayer.is_server():
		var test = func():
			does_it_work.rpc(player_id)
		test.call_deferred()

@rpc("call_local")
func does_it_work(id: int):
	print(id)
	set_multiplayer_authority(id)
		
func _input(event):
	if event is InputEventMouseMotion:
		transform = transform.rotated_local(Vector3.UP, -event.relative.x * HORIZONTAL_SENSITIVITY)
		tilt = clamp(tilt + -event.relative.y * VERTICAL_SENSITIVITY, -PI / 2, PI / 2)
		$Head.transform = head_transform.rotated_local(Vector3.RIGHT, tilt)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
