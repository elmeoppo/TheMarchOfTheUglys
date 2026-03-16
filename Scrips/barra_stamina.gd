extends Control
class_name BarraStamina
@export var player : Player
@onready var barra: TextureProgressBar = $Capa/Barra

@export var cantidad_manzanas: Cantidad_manzana
@onready var contador_frutas: Label = $Capa/contador_frutas


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	barra.max_value = player.saltos_maximos
	player.cambio_saltos_dados.connect(_on_saltos_cambio)
	

func _on_saltos_cambio():
	barra.value = player.saltos_dados
	print(player.saltos_dados)

func _process(delta: float) -> void:
	contador_frutas.text = str(cantidad_manzanas._manzanas_recogidas)
	
