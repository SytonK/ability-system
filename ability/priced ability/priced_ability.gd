class_name PricedAbility
extends Ability


signal cant_pay()


func _check_price() -> bool:
	var result: bool = _can_pay_price()
	if !result:
		cant_pay.emit()
	return result

func _can_pay_price() -> bool:
	return true

func _pay_price() -> void:
	pass


func _can_cast() -> bool:
	return super._can_cast() && _check_price()

func _cast_ability() -> void:
	_pay_price()
	super._cast_ability()
