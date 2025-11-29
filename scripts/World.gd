extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GlobalScript.gameFirstLoads == true:
		$Player.position.x = GlobalScript.playerStartPosx
		$Player.position.y = GlobalScript.playerStartPosy
	else:
		$Player.position.x = GlobalScript.playerExitCliffPosx
		$Player.position.y = GlobalScript.playerExitCliffPosy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	changeScene()


func _on_cliffside_transition_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		GlobalScript.transitionScene = true
		
func changeScene():
	if GlobalScript.transitionScene == true:
		if GlobalScript.currentScene == 'world':
			get_tree().change_scene_to_file("res://scenes/cliffside.tscn")
			GlobalScript.gameFirstLoads = false
			GlobalScript.finishChangingScene()
