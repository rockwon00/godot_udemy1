extends Node

@export var upgrade_pool : Array[AbilityUpgrade]
@export var experience_manager : Node
@export var upgrade_screen_scene : PackedScene

var current_upgrades = {}


func _ready():
	experience_manager.level_up.connect(on_level_up)
	

func apply_upgrade(upgrade : AbilityUpgrade):
	# has() : 주어진 키가 딕셔너리에 있는지 확인, 있으면 true, 없으면 false
	var has_upgrade = current_upgrades.has(upgrade.id)
	if !has_upgrade: #업그레이드가 없다면
		current_upgrades[upgrade.id] = {
			"resource" : upgrade,
			"quantity" : 1
		}
	else: #딕셔너리(사전)에 이미 키가 있다면
		current_upgrades[upgrade.id]["quantity"] += 1	
	
	#print(current_upgrades)
	
	if upgrade.max_quantity > 0:
		var current_quantity = current_upgrades[upgrade.id]["quantity"]
		if current_quantity == upgrade.max_quantity:
			upgrade_pool = upgrade_pool.filter(func(pool_upgrade): return pool_upgrade.id != upgrade.id)

	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)
	
	
func pick_upgrades():
	var chosen_upgrades = [] as Array[AbilityUpgrade]
	var filtered_upgrades = upgrade_pool.duplicate()
	for i in 2:
		if filtered_upgrades.size() == 0:
			break
		var chosen_upgrade = filtered_upgrades.pick_random() as AbilityUpgrade
		chosen_upgrades.append(chosen_upgrade)	
		# 인라인 함수, 람다 함수 개념, filter()함수 개념을 알아야 함 
		# filter()에 의하여 새배열이 반환되므로 filtered_upgrades를 재정의 해야함 
		filtered_upgrades = filtered_upgrades.filter(func(upgrade): return upgrade.id != chosen_upgrade.id)
		
	return chosen_upgrades
	
	
func on_upgrade_selected(upgrade : AbilityUpgrade):
	apply_upgrade(upgrade)
	
	
func on_level_up(current_level: int):
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	var chosen_upgrades = pick_upgrades()
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
