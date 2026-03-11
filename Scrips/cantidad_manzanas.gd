class_name Cantidad_manzana
extends Node

var _total_manzanas : int
var _manzanas_recogidas : int =0

@export var player : Player

func _ready() -> void:
	var manzanas := get_children()
	_total_manzanas = manzanas.size()
	
	for manzana in manzanas:
		if manzana.has_method("_recogida") or "contenedor_manzanas" in manzana:
			manzana.contenedor_manzanas = self

func manzana_recogida() :
	_manzanas_recogidas += 1
	print("Manzanas: ", _manzanas_recogidas)
	
	if _manzanas_recogidas == 3:
		nyan_mode()
	
	if _manzanas_recogidas == _total_manzanas:
		print("nivel comido")
	
func nyan_mode():
	if player:
		player.inicio_nyan_mode()
