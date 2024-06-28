class_name PricedAbility
extends Ability


func _can_pay_price() -> bool:
	return true

func _pay_price() -> void:
	pass


func _can_cast() -> bool:
	return super._can_cast() && _can_pay_price()

func _cast_ability() -> void:
	_pay_price()
	super._cast_ability()
