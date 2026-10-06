extends MarginContainer

@export var starting_gold: int = 150

var current_gold: int:
	set(g):
		current_gold = max(g, 0)
		label.text = "Gold: " + str(current_gold)

@onready var label: Label = $Label


func _ready() -> void:
	current_gold = starting_gold
