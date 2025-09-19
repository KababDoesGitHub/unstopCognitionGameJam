extends Area2D

var has_been_pressed=false

signal bluePressurePlatePressed

func _on_body_entered(_body: Node2D) -> void:
	bluePressurePlatePressed.emit()
	if not has_been_pressed:
		has_been_pressed=true
		$pressurePlateSprite.play("Press")
