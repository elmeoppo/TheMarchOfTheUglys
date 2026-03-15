extends Node2D

@export var vel_peces : float = 100.0

@export var velocidad_retroceso : float = 300.0

var jugador : Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= vel_peces*delta
	if jugador : 
		jugador.velocity.x -= velocidad_retroceso
		
	



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	self.queue_free()


func _on_pez_1_body_entered(body: Node2D) -> void:
	if body is Player :
		jugador = body


func _on_pez_1_body_exited(body: Node2D) -> void:
	if jugador == body:
		jugador = null
