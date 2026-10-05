extends Node

@export var game_length: float = 30.0
@export var spawn_time_curve: Curve

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.start(game_length)


func get_spawn_time() -> float:
	var game_progress_ratio = _compute_game_progress_ratio()
	return spawn_time_curve.sample(game_progress_ratio)


func _compute_game_progress_ratio() -> float:
	return 1.0 - (timer.time_left / game_length)
