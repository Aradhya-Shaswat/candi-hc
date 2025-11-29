extends CharacterBody2D

var speed = 38
var playerChase = false
var player = null

var health = 100
var playerAttackZone = false
var canTakeDamage = true

func _physics_process(delta):
	dealDamage()
	updateHealth()
	
	if playerChase:
		if position.distance_to(player.position) > 10:
			
			position += (player.position - position).normalized() * speed * delta
			$AnimatedSprite2D.play("walk")
			
			if (player.position.x-position.x)<0:
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
	move_and_slide()


func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	playerChase = true

func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	playerChase = false
	
func enemy():
	pass

func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		playerAttackZone = true


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		playerAttackZone = false

func dealDamage():
	if playerAttackZone and GlobalScript.playerCurrentAttack == true:
		if canTakeDamage == true:
			health = health - 40
			$takeDamageCooldown.start()
			canTakeDamage = false
			print('enemy health:', health)
			if health <= 0:
				self.queue_free()


func _on_take_damage_cooldown_timeout() -> void:
	canTakeDamage = true

func updateHealth():
	var healthBar = $HealthBar
	
	healthBar.value = health
	
	if health >= 100:
		healthBar.visible = false
	else:
		healthBar.visible = true
		
		
		
