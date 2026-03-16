extends Node2D
var ENDING = load("uid://ehs7bapefjya")



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		get_tree().change_scene_to_packed(ENDING)
