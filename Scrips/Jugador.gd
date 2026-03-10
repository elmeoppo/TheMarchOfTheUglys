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
var tocando_piso : bool:
	set(value):
		if value != tocando_piso:
			tocando_piso = value
			if tocando_piso:
				toco_piso.emit()

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

#VARIABLES DE VELOCIDAD Y GRAVEDAD

const SPEED : float = 300.0
const JUMP_VELOCITY : float = -350.0
signal moving(direction : float)
signal stop
signal saltos_maximos_alcanzados
signal toco_piso
signal cambio_saltos_dados
@export var gravedad_agua : float = 350.0

#VARIABLES DE MAXIMO NUMERO DE SALTOS

@export var saltos_dados : int = 0:
	set(value):
		saltos_dados = value
		cambio_saltos_dados.emit()
@export var saltos_maximos : int = 3
@export var ultimo_salto_registrado : int = -1
var cansado : bool = false


func _ready() -> void:
	moving.connect(_on_moving)
	stop.connect(_on_stop)
	saltos_maximos_alcanzados.connect(_on_max_saltos)
	toco_piso.connect(_on_tocar_piso)
	timer.timeout.connect(_termino_recuperacion_tiempo)

func _physics_process(delta: float) -> void:
	#print(timer.time_left)
	tocando_piso = is_on_floor()
	if not tocando_piso:
		velocity.y += gravedad_agua * delta
	direction = Input.get_axis("izquierda", "derecha")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func _input(event: InputEvent) -> void:
	# Manejar salto
	if event.is_action_pressed("salto"):
		_evaluar_saltos()

func _evaluar_saltos():
	if saltos_dados < saltos_maximos:
		velocity.y = JUMP_VELOCITY
		saltos_dados += 1
	if saltos_dados == saltos_maximos:
		cansado = true
		saltos_maximos_alcanzados.emit()

func _on_tocar_piso():
	print("TOCANDO PISO")
	animated_sprite_2d.play("idle")
	timer.start(1.0)

func _termino_recuperacion_tiempo():
	if saltos_dados != 0.0:
		saltos_dados -= 1
	if saltos_dados == 0:
		cansado = false
		timer.stop()

func _on_moving(dir: float) -> void:
	if not cansado:
		animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("sudor")
	if dir > 0.0:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true

func _on_stop() -> void:
	animated_sprite_2d.play("idle")

func _on_max_saltos():
	animated_sprite_2d.play("sudor")

func prueba ():
	print("Esto es una prueba")
