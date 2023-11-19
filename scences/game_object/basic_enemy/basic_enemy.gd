extends CharacterBody2D

const MAX_SPEED = 75

@onready var health_component : HealthComponent = $HealthComponent


func _process(delta):
	var direction = get_direction_to_player()
	velocity = direction * MAX_SPEED
	move_and_slide()

func get_direction_to_player():
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	if player_node != null:
		return (player_node.global_position - global_position).normalized()
	return Vector2.ZERO #플레이어가 NULL 인 경우

func on_area_entered(other_area:Area2D):
	health_component.damage(100)
