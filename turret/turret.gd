extends Node3D

@export var projectile_scene: PackedScene

var ennemy_path: Path3D

@onready var turret_top: MeshInstance3D = $TurretBase/TurretTop


func _physics_process(_delta: float) -> void:
	var ennemies = ennemy_path.get_children()
	var ennemy = ennemies.back()
	turret_top.look_at(ennemy.global_position, Vector3.UP, true)


func _shot() -> void:
	var projectile = projectile_scene.instantiate()
	add_child(projectile)
	projectile.global_position = turret_top.global_position
	projectile.direction = turret_top.global_basis.z


func _on_timer_timeout() -> void:
	_shot()
