class_name Ability
extends Node


@export var ability_key: String

@export var cooldown: float
var cooldown_timer: Timer
var is_on_cooldown: bool = false


func cast() -> void:
	pass


func _ready() -> void:
	_init_cooldown()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(ability_key) && _can_cast():
		_cast_ability()

func _can_cast() -> bool:
	return _check_cooldown()

func _cast_ability() -> void:
	_on_cast_cooldown()
	cast()


func _init_cooldown() -> void:
	if cooldown > 0:
		cooldown_timer = Timer.new()
		cooldown_timer.wait_time = cooldown
		cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
		add_child(cooldown_timer)

func _on_cooldown_timer_timeout() -> void:
	is_on_cooldown = false

func _check_cooldown() -> bool:
	return !is_on_cooldown

func _on_cast_cooldown() -> void:
	if cooldown > 0:
		is_on_cooldown = true
		cooldown_timer.start()

