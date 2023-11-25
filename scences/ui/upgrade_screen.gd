extends CanvasLayer

#중첩된 신호를 사용하는 이유 : 각 역활을 분리하기 위함, 클릭 감지ㅡ 업그레이드 분리 등
signal upgrade_selected(upgrade : AbilityUpgrade)

@export var upgrade_card_scene : PackedScene

@onready var card_container : HBoxContainer = $%CardContainer

func _ready():
	get_tree().paused = true

func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	for upgrade in upgrades:
		var card_instance = upgrade_card_scene.instantiate()
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		card_instance.selected.connect(on_upgrade_seleted.bind(upgrade))
		#select 신호는 그 자체로는 어떤 데이터를 보내지 않지만,bind를 통하여 추적가능하다.

func on_upgrade_seleted(upgrade : AbilityUpgrade): #신호애 의해 업그레이드를 수행한다.
	upgrade_selected.emit(upgrade)
	get_tree().paused = false
	queue_free()
