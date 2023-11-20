extends Node

@export var upgrade_pool : Array[AbilityUpgrade]
@export var experience_manager : Node

var current_upgrades = {}

func _ready():
	experience_manager.level_up.connect(on_level_up)
	
func on_level_up(current_level: int):
	var chosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	if chosen_upgrade == null:
		return
		
	var has_upgrade = current_upgrades.has(chosen_upgrade.id)
	if !has_upgrade: #업그레이드가 없다면
		current_upgrades[chosen_upgrade.id] = {
			"resource" : chosen_upgrade,
			"quantity" : 1
		}
	else: #딕셔너리(사전)에 이미 키가 있다면
		current_upgrades[chosen_upgrade.id]["quantity"] += 1	
		
	print(current_upgrades)
