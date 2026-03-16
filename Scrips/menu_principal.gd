extends Control
const CARTA = preload("uid://camoad7x0wn7b")
@onready var point_light_2d: PointLight2D = $PointLight2D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("continuar"):
		get_tree().change_scene_to_packed(CARTA)



func _on_timer_timeout() -> void:
	point_light_2d.texture_scale = randf_range(0.5,1.0)
