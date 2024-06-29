class_name PricedAbilityExample
extends PricedAbility


@onready var example: PriceExample = owner


func _cast() -> void:
	super._cast()
	print('cast with price')

func _can_pay_price() -> bool:
	var result = example.mana > 0
	if !result:
		cant_pay.emit()
	return result

func _pay_price() -> void:
	example.mana -= 1
