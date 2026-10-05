extends Node

@export var turret_scene: PackedScene
@export var enemy_path: Path3D


func build_turret(position: Vector3) -> void:
	var turret = turret_scene.instantiate()
	add_child(turret)
	turret.global_position = position
	turret.enemy_path = enemy_path
