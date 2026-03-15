extends StaticBody2D
class_name erizo_mar

@export var daño: int = 1

func _on_area_2d_body_entered(body):
	if body is Player : 
		body.recibir_daño(daño)

	
