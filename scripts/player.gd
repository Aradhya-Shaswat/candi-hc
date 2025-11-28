extends CharacterBody2D

const SPEED = 100

var current_dir = 'none'

func _ready():
	$AnimatedSprite2D.play('frontIdle')

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		current_dir = 'right'
		play_anim(1)
		input_vector.x = 1
	elif Input.is_action_pressed("ui_left"):
		current_dir = 'left'
		play_anim(1)
		input_vector.x = -1
	elif Input.is_action_pressed("ui_down"):
		current_dir = 'down'
		play_anim(1)
		input_vector.y = 1
	elif Input.is_action_pressed("ui_up"):
		current_dir = 'up'
		play_anim(1)
		input_vector.y = -1
	else:
		play_anim(0)
		input_vector.x = 0
		input_vector.y = 0
		
	velocity = input_vector * SPEED
	move_and_slide()
	
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == 'right':
		anim.flip_h = false
		if movement == 1:
			anim.play('sideWalk')
		elif movement == 0:
			anim.play('sideIdle')
			
	if dir == 'left':
		anim.flip_h = true
		if movement == 1:
			anim.play('sideWalk')
		elif movement == 0:
			anim.play('sideIdle')
			
	if dir == 'down':
		anim.flip_h = false
		if movement == 1:
			anim.play('frontWalk')
		elif movement == 0:
			anim.play('frontIdle')
			
	if dir == 'up':
		anim.flip_h = false
		if movement == 1:
			anim.play('backWalk')
		elif movement == 0:
			anim.play('backIdle')
		
			
			
			
				
	
	
	
	
