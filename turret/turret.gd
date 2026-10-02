extends Node3D

@export var projectile_scene: PackedScene


func _ready() -> void:
	_shot()


func _shot() -> void:
	var projectile = projectile_scene.instantiate()
	add_child(projectile)
