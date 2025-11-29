extends CheckButton

func _ready() -> void:
	# restore saved value
	pressed = bool(GlobalScript.hardMode)

	# ensure signal is connected (safe to call even if already connected)
	if not is_connected("toggled", Callable(self, "_on_toggled")):
		connect("toggled", Callable(self, "_on_toggled"))

func _on_toggled(on: bool) -> void:
	GlobalScript.hardMode = bool(on)
	print("-- toggled handler -- GlobalScript.hardMode set to:", GlobalScript.hardMode)
