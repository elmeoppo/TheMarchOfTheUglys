extends CharacterBody2D
class_name Player

@onready var hitbox_player: CollisionShape2D = $hitbox_player
@onready var barra: TextureProgressBar = $Capa/Barra

@export var multiplicador_velocidad : int = 2
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

#Variables vida

signal vida_cambiada(nueva_vida)

var vida_max: int = 6
var vida_minima = 0
var vida_actual: int = 6
var invencible : bool = false

func recibir_daño(value):
	
	if not invencible:
		
		vida_actual -= value
		vida_actual = clamp(vida_actual, 0 , vida_max)
		vida_cambiada.emit(vida_actual)
		print("Vida restante: ", vida_actual)
		
		if vida_actual <= 0:
			morir()
		
		if not herido:
			herido = true
			animated_sprite_2d.play("lloron")
			await get_tree().create_timer(3.0).timeout
			herido = false
			if direction != 0.0:
				_on_moving(direction)
			else:
				_on_stop()
				
	elif invencible:
		pass
	
func morir():
	get_tree().reload_current_scene()

#VARIABLES DE VELOCIDAD Y GRAVEDAD
#hola

var SPEED : float = 300.0
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
var modo_nyan : bool =false
var herido : bool = false

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
		
	if position.y >= 1000 :
		morir()
	else:
		pass
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	# Manejar salto
	if event.is_action_pressed("salto"):
		_evaluar_saltos()

func animacion_salto():
	
	if herido: return
	if not modo_nyan:
		animated_sprite_2d.play("salto")

func _evaluar_saltos():
	if saltos_dados < saltos_maximos:
		velocity.y = JUMP_VELOCITY
		saltos_dados += 1
		animacion_salto()
	if saltos_dados == saltos_maximos:
		cansado = true
		saltos_maximos_alcanzados.emit()
	

func _on_tocar_piso():
	print("TOCANDO PISO")
	if not herido:
		animated_sprite_2d.play("idle")
	timer.start(3.0)

func _termino_recuperacion_tiempo():
	if saltos_dados != 0.0:
		saltos_dados -= 1
	if saltos_dados == 0:
		cansado = false
		timer.stop()

func _on_moving(dir: float) -> void:
	if herido: return
	
	if not cansado and not modo_nyan:
		animated_sprite_2d.play("walk")
	elif cansado and not modo_nyan:
		animated_sprite_2d.play("sudor")
	elif not cansado and modo_nyan:
		animated_sprite_2d.play("nyan")
	if dir > 0.0:
		animated_sprite_2d.flip_h = false
	else:
		animated_sprite_2d.flip_h = true
	

func _on_stop() -> void:
	if herido: return
	animated_sprite_2d.play("idle")

func _on_max_saltos():
	if herido: return
	animated_sprite_2d.play("sudor")

func prueba ():
	print("Esto es una prueba")

func inicio_nyan_mode():
	print ("inicia")
	modo_nyan = true
	animated_sprite_2d.play("nyan")
	SPEED = SPEED * multiplicador_velocidad
	invencible = true

func final_nyan_mode():
	print ("termina")
	modo_nyan = false
	animated_sprite_2d.play("idle")
	SPEED = SPEED / multiplicador_velocidad
	invencible = false
