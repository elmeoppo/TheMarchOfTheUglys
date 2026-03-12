extends Control

@onready var barra: TextureProgressBar = $Capa/Barra
@export var player : Player

func _ready():
	player.vida_cambiada.connect(_actualizar_barra)
	barra.value = player.vida_actual

func _actualizar_barra(nueva_vida):
	barra.value = nueva_vida
