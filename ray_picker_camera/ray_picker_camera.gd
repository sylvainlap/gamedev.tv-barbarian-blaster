extends Camera3D

@export var distance: float = 100.0
@export var grid_map: GridMap
@export var turret_manager: Node
@export var turret_cost: int = 100

@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var bank = get_tree().get_first_node_in_group("Bank")


func _process(_delta: float) -> void:
	var mouse_position: Vector2 = get_viewport().get_mouse_position()
	ray_cast_3d.target_position = project_local_ray_normal(mouse_position) * distance
	ray_cast_3d.force_raycast_update()
	
	if ray_cast_3d.is_colliding():
		if bank.current_gold >= turret_cost:
			Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
			var collider = ray_cast_3d.get_collider()
			if Input.is_action_just_pressed("click") && collider is GridMap:
				var collision_point = ray_cast_3d.get_collision_point()
				var cell = grid_map.local_to_map(collision_point)
				if grid_map.get_cell_item(cell) == 0:
					grid_map.set_cell_item(cell, 1)
					var tile_position = grid_map.map_to_local(cell)
					turret_manager.build_turret(tile_position)
					bank.current_gold -= turret_cost
		else:
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	
