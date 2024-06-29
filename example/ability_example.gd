extends Ability


func _cast() -> void:
	super._cast()
	print('cast')


func _on_on_cooldown() -> void:
	print('on_cooldown')


func _on_no_charges() -> void:
	print('no charges')
