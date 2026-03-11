extends Node2D

@export var area_2d: Area2D
var contenedor_manzanas: Cantidad_manzana

func _ready() -> void:
	area_2d.body_entered.connect(_recogida) 
	


func _recogida(_body):
	contenedor_manzanas.manzana_recogida()
	queue_free()
