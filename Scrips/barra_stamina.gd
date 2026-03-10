extends Control
class_name BarraStamina
@export var player : Player
@onready var barra: TextureProgressBar = $Capa/Barra

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	barra.value = player.saltos_maximos
	barra.max_value = player.saltos_maximos
	player.dio_salto.connect(_on_player_salto)
	

func _on_player_salto():
	if barra.value > barra.min_value:
		barra.value -= 1.0
	print(barra.value)
