extends Control
const MENU_PRINCIPAL = preload("uid://bo6h12jdfe2og")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("continuar"):
		get_tree().change_scene_to_packed(MENU_PRINCIPAL)
