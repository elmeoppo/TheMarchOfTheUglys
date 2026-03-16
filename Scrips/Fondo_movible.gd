extends Parallax2D
class_name FollowingBack
@export var jugador : Player
@export var velocity_multiplier : float = 1.0
var direction_player : float

var initial_pos

func _ready() -> void:
	print(initial_pos)
	jugador.moving.connect(move_back)
	jugador.stop.connect(stop_move_back)
	

func move_back(direction : float):
	direction_player = direction
	print(direction_player)

func stop_move_back():
	direction_player = 0

func _process(_delta: float) -> void:
	if direction_player != 0:
		scroll_offset.x -= (direction_player * velocity_multiplier)
