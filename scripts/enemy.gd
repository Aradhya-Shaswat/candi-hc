extends CharacterBody2D

var speed: float = 38.0
var playerChase: bool = false
var player: Node = null

var damage: int = 20
var health: int = 100
var playerAttackZone: bool = false
var canTakeDamage: bool = true

func _physics_process(delta: float) -> void:
	dealDamage()
	updateHealth()
	if playerChase:
		if player != null and position.distance_to(player.position) > 10:
			position += (player.position - position).normalized() * speed * delta
			$AnimatedSprite2D.play("walk")
			if (player.position.x - position.x) < 0:
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

func enemy() -> void:
	pass

func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		playerAttackZone = true

func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		playerAttackZone = false

func dealDamage() -> void:
	if playerAttackZone and GlobalScript.playerCurrentAttack and canTakeDamage:
		var pdmg = 20

		if player != null:
			var dmg_val = player.get("attack_damage")
			if typeof(dmg_val) == TYPE_INT:
				pdmg = dmg_val

		health -= pdmg
		canTakeDamage = false
		$takeDamageCooldown.start()

		if health <= 0:
			queue_free()

func get_damage() -> int:
	$hitTaken.play()
	return int(damage)

func _on_take_damage_cooldown_timeout() -> void:
	canTakeDamage = true

func updateHealth() -> void:
	var healthBar = $HealthBar
	healthBar.value = health
	healthBar.visible = not (health >= 100)
