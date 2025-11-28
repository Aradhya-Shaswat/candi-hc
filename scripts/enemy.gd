extends CharacterBody2D

var speed = 38
var playerChase = false
var player = null

func _physics_process(delta):
	
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
