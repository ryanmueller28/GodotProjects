extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const ACCELERATION = 500.0
const FRICTION = 500.0
var velocity = Vector2.ZERO


enum {
	MOVE,
	HOWL	
}

var state = MOVE
export var MAX_SPEED = 100.0

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		HOWL:
			howl_sate(delta)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func move_state(delta: float) -> void:
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	

	
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.play("WalkRight")
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite.play("WalkLeft")
	elif Input.is_action_pressed("ui_up"):
		$AnimatedSprite.play("WalkUp")
	elif Input.is_action_pressed("ui_down"):
		$AnimatedSprite.play("WalkDown")
	else:
		$AnimatedSprite.stop()
		
	move_and_slide(velocity)
	
	if Input.is_action_just_pressed("howl"):
		state = HOWL
	
func howl_sate(delta: float) -> void:
	$AnimatedSprite.play("HowlRight")	
	state = MOVE
