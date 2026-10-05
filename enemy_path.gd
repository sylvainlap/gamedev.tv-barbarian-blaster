extends Path3D

@export var enemy_scene: PackedScene
@export var difficulty_manager: Node

@onready var timer: Timer = $Timer


func _spawn_enemy() -> void:
	var enemy = enemy_scene.instantiate()
	add_child(enemy)


func _on_timer_timeout() -> void:
	_spawn_enemy()
	timer.wait_time = difficulty_manager.get_spawn_time()
