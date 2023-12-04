extends Node

@export var upgrade_pool : Array[AbilityUpgrade]
@export var experience_manager : Node
@export var upgrade_screen_scene : PackedScene

var current_upgrades = {}

func _ready():
	experience_manager.level_up.connect(on_level_up)
	
	
func apply_upgrade(upgrade : AbilityUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)
	if !has_upgrade: #업그레이드가 없다면
		current_upgrades[upgrade.id] = {
			"resource" : upgrade,
			"quantity" : 1
		}
	else: #딕셔너리(사전)에 이미 키가 있다면
		current_upgrades[upgrade.id]["quantity"] += 1	
	
	print(current_upgrades)

	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)
	
	
func pick_upgrades():
	var chosen_upgrades : Array[AbilityUpgrade] = []
	# 동일한 요소가 있는 새 배열을 반환
	var filtered_upgrades = upgrade_pool.duplicate()
	for i in 2:
		# 필터링된 업그레이트 풀 배열의 복사본
		var chosen_upgrade = filtered_upgrades.pick_random() as AbilityUpgrade
		chosen_upgrades.append(chosen_upgrade)
		filtered_upgrades =  filtered_upgrades.filter(func (upgrade): return upgrade.id != chosen_upgrade.id)
	
	return chosen_upgrades
	
	
func on_upgrade_selected(upgrade : AbilityUpgrade):
	apply_upgrade(upgrade)


# 모든 신호를 처리하는 메서드를 스크립트 하단에 두는 것을 추천
func on_level_up(current_level: int):
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	var chosen_upgrades = pick_upgrades()
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
