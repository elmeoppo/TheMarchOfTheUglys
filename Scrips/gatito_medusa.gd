extends StaticBody2D
class_name gatito_medusa

@export var daño: int = 1

@onready var player_animacion: AnimationPlayer = $Player_Animacion

@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D


func _on_area_2d_body_entered(body):
	if body is Player : 
		body.recibir_daño(daño)
		player_animacion.play("particulas")
		gpu_particles_2d.emitting = true

func _ready() -> void:
	player_animacion.animation_finished.connect(animacion_Acabada)
	

func animacion_Acabada(nombre_animacion : String):
	if nombre_animacion == "particulas":
		queue_free()
	
