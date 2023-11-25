extends PanelContainer

signal selected

@onready var name_label : Label = $%NameLable
@onready var description_label : Label = $%DescriptionLable

func _ready():
	gui_input.connect(on_gui_input)

func set_ability_upgrade(upgrade : AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description

func on_gui_input(event : InputEvent):
	if event.is_action_pressed("left_click"):
		selected.emit() #마우스 우클릭을 실행하면 신호(selected)를 방출 한다 
