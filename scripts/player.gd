extends CharacterBody2D

var ifEnemyRange = false
var enemyAttackCooldown = true
var health = 200
var isPlayerAlive = true

var attackIp = false # Ip = in progress

const SPEED = 100
var current_dir = 'none'

func _ready():
	$AnimatedSprite2D.play('frontIdle')

func _physics_process(delta):
	player_movement(delta)
	enemyAttack()
	attack()
	
	if health <= 0:
		isPlayerAlive = false
		# todo: add screen for death
		health = 0
		print('player died')
		self.queue_free()

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
			if attackIp == false:
				anim.play('sideIdle')
			
	if dir == 'left':
		anim.flip_h = true
		if movement == 1:
			anim.play('sideWalk')
		elif movement == 0:
			if attackIp == false:
				anim.play('sideIdle')
			
	if dir == 'down':
		anim.flip_h = false
		if movement == 1:
			anim.play('frontWalk')
		elif movement == 0:
			if attackIp == false:
				anim.play('frontIdle')
			
	if dir == 'up':
		anim.flip_h = false
		if movement == 1:
			anim.play('backWalk')
		elif movement == 0:
			if attackIp == false:
				anim.play('backIdle')
			
func player():
	pass

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method('enemy'):
		ifEnemyRange = true

func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method('enemy'):
		ifEnemyRange = false
		
		
func enemyAttack():
	if ifEnemyRange and enemyAttackCooldown == true:
		health = health - 20
		enemyAttackCooldown = false
		$attackCooldown.start()
		
		print(health)

func _on_attack_cooldown_timeout() -> void:
	enemyAttackCooldown = true
	
	
func attack():
	var dir = current_dir
	
	if Input.is_action_just_pressed('attack'):
		GlobalScript.playerCurrentAttack = true
		attackIp = true
		if dir == 'right':
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play('sideAttack')
			$dealAttack.start()
		if dir == 'left':
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play('sideAttack')
			$dealAttack.start()
		if dir == 'down':
			$AnimatedSprite2D.play('frontAttack')
			$dealAttack.start()
		if dir == 'up':
			$AnimatedSprite2D.play('backAttack')
			$dealAttack.start()

func _on_deal_attack_timeout() -> void:
	$dealAttack.stop()
	GlobalScript.playerCurrentAttack = false
	attackIp = false
