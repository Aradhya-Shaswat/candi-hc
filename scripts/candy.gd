extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	changeScenes()

func changeScenes():
	if GlobalScript.candyTransitionScene == true:
		if GlobalScript.currentScene == 'candy':
			get_tree().change_scene_to_file("res://scenes/world_1.tscn")
			GlobalScript.finishChangingSceneCandy()

func _on_candy_exit_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		GlobalScript.candyTransitionScene = true
