extends CharacterBody2D

var ifEnemyRange: bool = false
var enemyAttackCooldown: bool = true
var health: int = 100
var isPlayerAlive: bool = true

var attackIp: bool = false

@export var speed: float = 80.0
var current_dir: String = "none"

var attack_damage: int = 20
var currentEnemy: Node = null
var invulnerable: bool = false

func _ready() -> void:
	$AnimatedSprite2D.play("frontIdle")

func _physics_process(delta: float) -> void:
	player_movement(delta)
	enemyAttack()
	attack()
	currentCamera()
	updateHealth()

	if health <= 0:
		GlobalScript.gameFirstLoads = true
		GlobalScript.candyExit = false
		GlobalScript.cliffExit = false
		isPlayerAlive = false
		health = 0
		get_tree().change_scene_to_file("res://scenes/death.tscn")
		queue_free()

func player() -> void:
	pass

func player_movement(delta: float) -> void:
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1

	if input_vector.x > 0:
		current_dir = "right"
	elif input_vector.x < 0:
		current_dir = "left"
	elif input_vector.y > 0:
		current_dir = "down"
	elif input_vector.y < 0:
		current_dir = "up"

	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()
		velocity = input_vector * speed
	else:
		velocity = Vector2.ZERO

	if not attackIp:
		if velocity.length() > 0:
			_play_movement_anim(true)
		else:
			_play_movement_anim(false)

	move_and_slide()

func _play_movement_anim(moving: bool) -> void:
	var anim = $AnimatedSprite2D
	var a = ""

	if current_dir == "right":
		anim.flip_h = false
		a = "sideWalk" if moving else "sideIdle"
	elif current_dir == "left":
		anim.flip_h = true
		a = "sideWalk" if moving else "sideIdle"
	elif current_dir == "down":
		anim.flip_h = false
		a = "frontWalk" if moving else "frontIdle"
	elif current_dir == "up":
		anim.flip_h = false
		a = "backWalk" if moving else "backIdle"

	if anim.animation != a:
		anim.play(a)

func attack() -> void:
	if Input.is_action_just_pressed("attack"):
		attackIp = true

		var anim = $AnimatedSprite2D
		if current_dir == "right":
			anim.flip_h = false
			anim.play("sideAttack")
		elif current_dir == "left":
			anim.flip_h = true
			anim.play("sideAttack")
		elif current_dir == "down":
			anim.play("frontAttack")
		elif current_dir == "up":
			anim.play("backAttack")

		$dealAttack.start()
		GlobalScript.playerCurrentAttack = true

func _on_deal_attack_timeout() -> void:
	$dealAttack.stop()
	GlobalScript.playerCurrentAttack = false
	attackIp = false

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		ifEnemyRange = true
		currentEnemy = body

func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		ifEnemyRange = false
		currentEnemy = null

func enemyAttack() -> void:
	if ifEnemyRange and enemyAttackCooldown and currentEnemy and not invulnerable:
		if currentEnemy.has_method("get_damage"):
			health -= currentEnemy.get_damage()
		elif currentEnemy.has_variable("damage"):
			health -= int(currentEnemy.damage)
		else:
			health -= 20

		enemyAttackCooldown = false
		invulnerable = true
		$attackCooldown.start()

func _on_attack_cooldown_timeout() -> void:
	enemyAttackCooldown = true
	invulnerable = false

func currentCamera() -> void:
	if GlobalScript.currentScene == "world":
		$worldCamera.make_current()
	else:
		$cliffsideCamera.make_current()

func updateHealth() -> void:
	var healthBar = $HealthBar
	healthBar.value = health
	healthBar.visible = not (health >= 100)

func _on_regen_timer_timeout() -> void:
	if health < 100:
		health += 2.5
		if health > 100:
			health = 100
	if health <= 0:
		health = 0
