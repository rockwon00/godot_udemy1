extends Node

const SPAWN_RADIUS = 100

@export var basic_enemy_scene : PackedScene
@export var arena_time_manager : Node

@onready var timer = $Timer

var base_spwan_time = 0

func _ready():
	base_spwan_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)

<<<<<<< HEAD

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
=======
func get_spawn_position():
>>>>>>> 76db276a54bfcc9897fd39e202b4f6f8fd26351a
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return Vector2.ZERO
	# 초기 스폰 위치와 무작위 방향 할당 
	var spawn_position = Vector2.ZERO
	var random_direction = Vector2.RIGHT.rotated(randf_range(0,TAU))
	for i in 4:
		# 스폰 방뱡 할당 : 플레이어의 현재위치 + 임의의 방향(방향 단위백터 * 생성 반경)
		spawn_position = player.global_position + (random_direction * SPAWN_RADIUS)
		# 플레이어 위치(시작점)에서 스폰위치(끝점)를 향하는 광선 생선    
		var query_parameters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1)
		# intersect_ray 호출 : 광선이 교차하는지 확인
		# intersect_ray 의 충돌 객체가 없으면 빈 딕셔너리를 반납 한다(null 값이 아님) 
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_parameters)			 

		if result.is_empty(): 
			# 광선의 쏜 결과 리턴값이 비어있으면 루프의 실행을 중지하고 루프가 실행되지 않더라도 진행을 중
			break
		else: 
			# 광선을 쏜 결과 리턴값이 비어있지 않으면 90도 회전하여 임의의 방향 변경 후 for 루프 돌아감
			random_direction = random_direction.rotated(deg_to_rad(90))

	return spawn_position

func on_timer_timeout():
	timer.start()
	
<<<<<<< HEAD
=======
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return Vector2.ZERO

>>>>>>> 76db276a54bfcc9897fd39e202b4f6f8fd26351a
	var enemy = basic_enemy_scene.instantiate() as Node2D
	
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
<<<<<<< HEAD
	enemy.global_position = get_sqawn_position()

=======
	enemy.global_position = get_spawn_position()
	
func on_arena_difficulty_increased(arena_difficulty : int):
	var time_off = (.1 / 12) * arena_difficulty
	time_off = min(time_off, .7) 
	print(time_off)
	timer.wait_time = base_spwan_time - time_off
>>>>>>> 76db276a54bfcc9897fd39e202b4f6f8fd26351a
