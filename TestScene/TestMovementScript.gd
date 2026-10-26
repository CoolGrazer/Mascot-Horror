extends CharacterBody3D

@export var acceleration : float = 1.0

@export var max_speed : float = 10.0


@export_category("Jump Logic")
@export var jump_height : float = 2.0
@export var jump_gravity : float = 0.25
@export var jump_lag_secs : float = 2.0

var horizontal_speed : float = 0.0
var last_held_direction : Vector2



func _physics_process(delta: float) -> void:
	var direction : Vector2 = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	if direction.length() > 0.15:
		horizontal_speed = move_toward(horizontal_speed,max_speed,acceleration)
	else:
		direction = last_held_direction
		horizontal_speed = move_toward(horizontal_speed,0,acceleration)
	
	
	velocity.x = direction.x * horizontal_speed
	velocity.z = direction.y * horizontal_speed
	
	if !is_on_floor():
		velocity.y -= jump_gravity
	else:
		
		
		velocity.y = 0
		
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = jump_height
	
	
	if direction.length() > 0.15:
		last_held_direction = direction
	move_and_slide()
