extends Node2D

@export var escena_a_spawnear : PackedScene
@export var tiempo_spawner : float

@onready var timer_pez: Timer = $Timer_pez

func spawnear():
	
	var nueva_escena = escena_a_spawnear.instantiate()
	self.add_child(nueva_escena)

func _ready() -> void:

	timer_pez.start(tiempo_spawner)
	timer_pez.timeout.connect(spawnear)
