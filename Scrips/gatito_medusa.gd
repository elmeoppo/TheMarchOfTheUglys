extends CharacterBody2D
class_name gatito_medusa

@export var daño: int = 40

func _on_area_2d_body_entered(body):
	if body.has_method("recibir_daño"):
		body.recibir_daño(daño)
