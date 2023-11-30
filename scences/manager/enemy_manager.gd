extends Node

const SPAWN_RADIUS = 375

@export var basic_enemy_scene : PackedScene

func _ready():
	$Timer.timeout.connect(on_timer_timeout)


func get_sqawn_position():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return Vector2.ZERO
	
	# 초기 스폰 위치 
	var spawn_position = Vector2.ZERO
	# 초기 무작위 방향  
	var random_direction = Vector2.RIGHT.rotated(randf_range(0,TAU))	
	
	# 반복문으로 생성 위치 가져옴
	for i in 4:
		spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
	# 지형 레이어에 충돌이 있는지 확인
		var query_paramaters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1)
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_paramaters)
				
		if result.is_empty():
			break
		else:
			random_direction = random_direction.rotated(deg_to_rad(90))
	
	return spawn_position
		
		
func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var enemy = basic_enemy_scene.instantiate() as Node2D
	
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
	enemy.global_position = get_sqawn_position()

