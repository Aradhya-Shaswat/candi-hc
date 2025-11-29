extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GlobalScript.gameFirstLoads == true:
		$Player.position.x = GlobalScript.playerStartPosx
		$Player.position.y = GlobalScript.playerStartPosy
		
	elif GlobalScript.candyExit == true:
		$Player.position.x = GlobalScript.playerExitCandyPosx
		$Player.position.y = GlobalScript.playerExitCandyPosy
		
	elif GlobalScript.cliffExit == true:
		$Player.position.x = GlobalScript.playerExitCliffPosx
		$Player.position.y = GlobalScript.playerExitCliffPosy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	changeCliffScene()
	changeCandyScene()


func _on_cliffside_transition_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		GlobalScript.cliffTransitionScene = true
		
func _on_candy_area_transition_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		GlobalScript.candyTransitionScene = true
		
func changeCliffScene():
	if GlobalScript.cliffTransitionScene == true:
		if GlobalScript.currentScene == 'world':
			get_tree().change_scene_to_file("res://scenes/cliffside.tscn")
			GlobalScript.cliffExit = true
			GlobalScript.candyExit = false
			GlobalScript.gameFirstLoads = false
			GlobalScript.finishChangingSceneCliff()

func changeCandyScene():
	if GlobalScript.candyTransitionScene == true:
		if GlobalScript.currentScene == 'world':
			get_tree().change_scene_to_file("res://scenes/candy.tscn")
			GlobalScript.candyExit = true
			GlobalScript.cliffExit = false
			GlobalScript.gameFirstLoads = false
			GlobalScript.finishChangingSceneCandy()
		
		
		
		
		
