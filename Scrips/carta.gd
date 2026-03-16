extends Control
const MUNDO = preload("uid://u1ehn2f7a005")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("continuar"):
		get_tree().change_scene_to_packed(MUNDO)
