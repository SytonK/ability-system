class_name PricedAbilityExample
extends PricedAbility


@onready var example: PriceExample = owner


func _cast() -> void:
	print('cast with price')

func _can_pay_price() -> bool:
	return example.mana > 0

func _pay_price() -> void:
	example.mana -= 1
