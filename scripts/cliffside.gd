extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	changeScenes()

func _on_cliffside_exit_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		GlobalScript.cliffTransitionScene = true

func changeScenes():
	if GlobalScript.cliffTransitionScene == true:
		if GlobalScript.currentScene == 'cliff_side':
			get_tree().change_scene_to_file("res://scenes/world_1.tscn")
			GlobalScript.finishChangingSceneCliff()
