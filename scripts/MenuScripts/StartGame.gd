extends Control

@export var hover_player_path: NodePath
@export var click_player_path: NodePath

var button_scene_map: Dictionary = {
	"NewGame": "res://scenes/world_1.tscn",
	"Options": "res://scenes/options.tscn",
	"Credits": "res://scenes/credits.tscn",
	"Exit": "__QUIT__"
}

@onready var hover_player: AudioStreamPlayer = get_node_or_null(hover_player_path)
@onready var click_player: AudioStreamPlayer = get_node_or_null(click_player_path)

func _ready() -> void:
	_connect_buttons_recursive(self)

func _connect_buttons_recursive(node: Node) -> void:
	for child in node.get_children():
		if child is Button:
			_connect_button(child)
		_connect_buttons_recursive(child)

func _connect_button(btn: Button) -> void:
	var hover_cb: Callable = Callable(self, "_on_button_hover").bind(btn)
	var pressed_cb: Callable = Callable(self, "_on_button_pressed").bind(btn)

	if not btn.is_connected("mouse_entered", Callable(self, "_on_button_hover")):
		btn.mouse_entered.connect(hover_cb)
	if not btn.is_connected("pressed", Callable(self, "_on_button_pressed")):
		btn.pressed.connect(pressed_cb)

func _on_button_hover(btn: Button) -> void:
	if hover_player:
		hover_player.stop()
		hover_player.play()

func _on_button_pressed(btn: Button) -> void:
	if click_player:
		click_player.stop()
		click_player.play()

	var target: String = button_scene_map.get(btn.name, "") as String

	if target == "__QUIT__":
		get_tree().quit()
	elif target != "":
		print(GlobalScript.hardMode)
		get_tree().change_scene_to_file(target)
	else:
		print_debug("No scene mapped for button:", btn.name)
