extends CharacterBody2D
class_name Player

var entera : int = 1
var flot : float = 1
var boleana : bool = false
var string : String = "pan con queso"
var direction : float :
	set(value):
		if value != direction:
			direction = value
			if direction != 0.0:
				moving.emit(direction)
			else :
				stop.emit()

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#VARIABLES DE VELOCIDAD Y GRAVEDAD

const SPEED : float = 300.0
const JUMP_VELOCITY : float = -350.0
signal moving(direction : float)
signal stop
var gravedad_agua : float = 350.0

#VARIABLES DE MAXIMO NUMERO DE SALTOS

var saltos_dados : int = 0
var saltos_maximos : int = 3
var ultimo_salto_registrado : int = -1

#VARIABLES DE ESTAMINA

var estamina_max : float = 150.0
var estamina_actual : float = 150.0
var costo_salto : float = 50.0
var recuperacion_aire : float = 5.0
var recuperacion_suelo : float = 40.0

func _ready() -> void:
	moving.connect(_on_moving)
	stop.connect(_on_stop)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravedad_agua * delta
		estamina_actual += recuperacion_aire * delta

	else:
		if saltos_dados !=0 :
			saltos_dados = 0
		estamina_actual += recuperacion_suelo * delta

	estamina_actual = clamp(estamina_actual, 0, estamina_max)

	# Handle jump.
	if Input.is_action_just_pressed("salto") and saltos_dados < saltos_maximos:
		velocity.y = JUMP_VELOCITY
		saltos_dados += 1
		estamina_actual -= costo_salto
	
	if estamina_actual < 40.0:
		if animated_sprite_2d.animation != "sudor":
			animated_sprite_2d.play("sudor")
	else:
		if animated_sprite_2d.animation == "sudor":
			animated_sprite_2d.play("idle")
	
	if saltos_dados != ultimo_salto_registrado:
		print("Saltos actuales: ", saltos_dados)
		ultimo_salto_registrado = saltos_dados

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("izquierda", "derecha")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()



func _on_moving(dir: float) -> void:
	animated_sprite_2d.play("walk")
	if dir > 0.0:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true

func _on_stop() -> void:
	animated_sprite_2d.play("idle")



func prueba ():
	print("Esto es una prueba")
