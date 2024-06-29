class_name Ability
extends Node


signal on_cooldown
signal no_charges


@export var ability_key: String

@export var cooldown: float
var cooldown_timer: Timer
var is_on_cooldown: bool = false

@export var max_charges: int = 0
@export var charges: int : set = _set_charges
@export var charg_time: float = 0
var charg_timer: Timer

func _cast() -> void:
	_recharg_cooldown()


func _ready() -> void:
	_init_cooldown()
	_init_charges()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(ability_key) && _can_cast():
		_cast_ability()

func _can_cast() -> bool:
	return _check_cooldown() && _check_charges()

func _cast_ability() -> void:
	_on_cast_cooldown()
	_on_cast_charges()
	_cast()


func _init_cooldown() -> void:
	if cooldown <= 0:
		return
	
	cooldown_timer = Timer.new()
	cooldown_timer.wait_time = cooldown
	cooldown_timer.timeout.connect(_on_cooldown_timer_timeout)
	add_child(cooldown_timer)

func _on_cooldown_timer_timeout() -> void:
	is_on_cooldown = false

func _check_cooldown() -> bool:
	var result: bool = !is_on_cooldown
	if !result:
		on_cooldown.emit()
	return result

func _on_cast_cooldown() -> void:
	if cooldown > 0:
		is_on_cooldown = true

func _recharg_cooldown() -> void:
	if cooldown > 0:
		cooldown_timer.start()


func _init_charges() -> void:
	if charg_time <= 0:
		return
	
	charg_timer = Timer.new()
	charg_timer.wait_time = charg_time
	charg_timer.timeout.connect(_on_charg_timer_timeout)
	add_child(charg_timer)

func _set_charges(new_charges: int) -> void:
	charges = clamp(new_charges, 0, max_charges)

func _check_charges() -> bool:
	var result: bool = max_charges == 0 || charges > 0
	if !result:
		no_charges.emit()
	return result

func _on_cast_charges() -> void:
	if max_charges <= 0:
		return
	
	charges -= 1
	
	if charg_time > 0 && charg_timer.time_left == 0:
		charg_timer.start()

func _on_charg_timer_timeout() -> void:
	charges += 1
	if charges < max_charges:
		charg_timer.start()
