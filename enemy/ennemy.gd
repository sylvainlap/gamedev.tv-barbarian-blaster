extends PathFollow3D

@export var speed: float = 2.5
@export var max_health: int = 2
@export var gold_value: int = 15

var current_health: int:
	set(h):
		animation_player.play("take_damage")
		current_health = h
		if current_health < 1:
			bank.current_gold += gold_value
			queue_free()
	get:
		return current_health

@onready var base = get_tree().get_first_node_in_group("Base")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bank = get_tree().get_first_node_in_group("Bank")


func _ready() -> void:
	current_health = max_health


func _process(delta: float) -> void:
	progress += delta * speed
	
	if progress_ratio == 1.0:
		base.take_damage()
		set_process(false)


func take_damage() -> void:
	current_health -= 1
