extends Control
class_name BarraStamina
@export var player : Player
@onready var barra: TextureProgressBar = $Capa/Barra

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	barra.value = player.saltos_maximos
	barra.max_value = player.saltos_maximos
	
