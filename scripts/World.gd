extends Node2D

func _ready() -> void:
	if GlobalScript.gameFirstLoads:
		$Player.position.x = GlobalScript.playerStartPosx
		$Player.position.y = GlobalScript.playerStartPosy

	elif GlobalScript.candyExit:
		$Player.position.x = GlobalScript.playerExitCandyPosx
		$Player.position.y = GlobalScript.playerExitCandyPosy

	elif GlobalScript.cliffExit:
		$Player.position.x = GlobalScript.playerExitCliffPosx
		$Player.position.y = GlobalScript.playerExitCliffPosy

	apply_difficulty()

func apply_difficulty() -> void:
	if GlobalScript.hardMode:
		$Player.speed = 50.0
		$Player.attack_damage = 10
	else:
		$Player.speed = 80.0

func _process(delta: float) -> void:
	changeCliffScene()
	changeCandyScene()

func _on_cliffside_transition_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		GlobalScript.cliffTransitionScene = true

func _on_candy_area_transition_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		GlobalScript.candyTransitionScene = true

func changeCliffScene() -> void:
	if GlobalScript.cliffTransitionScene and GlobalScript.currentScene == "world":
		get_tree().change_scene_to_file("res://scenes/cliffside.tscn")
		GlobalScript.cliffExit = true
		GlobalScript.candyExit = false
		GlobalScript.gameFirstLoads = false
		GlobalScript.finishChangingSceneCliff()

func changeCandyScene() -> void:
	if GlobalScript.candyTransitionScene and GlobalScript.currentScene == "world":
		get_tree().change_scene_to_file("res://scenes/candy.tscn")
		GlobalScript.candyExit = true
		GlobalScript.cliffExit = false
		GlobalScript.gameFirstLoads = false
		GlobalScript.finishChangingSceneCandy()
