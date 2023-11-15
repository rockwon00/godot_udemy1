extends Node

@onready var timer = $Timer

func get_time_elapsed():
	return timer.wait_time - timer.time_left

func format_seconds_to_string(seconds :float):
	var minute = floor(seconds)
