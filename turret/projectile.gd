extends Area3D

@export var speed: float = 30.0
@export var damage: int = 25

var direction := Vector3.FORWARD


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("Enemy"):
		area.get_parent().take_damage(damage)
		queue_free()
