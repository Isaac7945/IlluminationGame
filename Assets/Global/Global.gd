extends Node

var battery_max = 82
var battery_min = 15
var battery: float = battery_max
var spawn_rate: int = 10
var zap_charge = 0
var hp: int = 3:
	set(value):
		hp = value
		ui.player_hit()
signal game_start
signal can_move
signal game_over
signal game_win
