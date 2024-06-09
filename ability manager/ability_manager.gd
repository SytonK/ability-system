class_name AbilityManager
extends Node


@export var ability: Ability
@export var ability_key: String


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(ability_key):
		ability.cast()
