extends PathFollow3D

@export var speed: float = 2.5
@export var gold_value: int = 15

var max_health: int
var _current_health: int:
	set(h):
		animation_player.play("take_damage")
		_current_health = h
		if _current_health < 1:
			bank.current_gold += gold_value
			queue_free()

@onready var base = get_tree().get_first_node_in_group("Base")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bank = get_tree().get_first_node_in_group("Bank")


func _ready() -> void:
	_current_health = max_health


func _process(delta: float) -> void:
	progress += delta * speed
	
	if progress_ratio == 1.0:
		base.take_damage()
		queue_free()


func take_damage(d: int) -> void:
	_current_health -= d
