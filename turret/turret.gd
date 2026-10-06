extends Node3D

@export var projectile_scene: PackedScene
@export var turret_range: float = 10.0

var enemy_path: Path3D
var target: PathFollow3D

@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cannon: Node3D = $Pivot/Cannon
@onready var pivot: Node3D = $Pivot


func _physics_process(_delta: float) -> void:
	target = _find_best_target()
	if target != null:
		pivot.look_at(target.global_position, Vector3.UP, true)


func _shoot() -> void:
	animation_player.play("shoot")
	var projectile = projectile_scene.instantiate()
	add_child(projectile)
	projectile.global_position = cannon.global_position
	projectile.direction = cannon.global_basis.z


func _find_best_target() -> PathFollow3D:
	var best_target = null
	var best_progress = 0

	for enemy in enemy_path.get_children():
		if enemy is PathFollow3D:
			var distance_from_target = global_position.distance_to(enemy.global_position)
			if distance_from_target < turret_range and enemy.progress > best_progress:
				best_progress = enemy.progress
				best_target = enemy
			
	return best_target


func _on_timer_timeout() -> void:
	if target:
		_shoot()
