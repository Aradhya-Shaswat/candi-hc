extends Button

func _on_pressed() -> void:
	get_tree().change_scene_to_file('res://scenes/world_1.tscn')

func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file('res://scenes/main_menu.tscn')

func _on_pressed_1() -> void:
	get_tree().change_scene_to_file('res://scenes/main_menu.tscn')
	
