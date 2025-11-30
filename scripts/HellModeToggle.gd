extends CheckButton

func _ready() -> void:
	#var pressed = GlobalScript.get_hard_mode()
	if not is_connected("toggled", Callable(self, "_on_toggled")):
		connect("toggled", Callable(self, "_on_toggled"))

func _on_toggled(on: bool) -> void:
	GlobalScript.set_hard_mode(on)
	print("-- toggled handler -- GlobalScript.hardMode set to:", GlobalScript.get_hard_mode())


func _on_back_pressed_1() -> void:
	get_tree().change_scene_to_file('res://scenes/main_menu.tscn')
