extends Area2D

var has_been_pressed=false

func _on_body_entered(body: Node2D) -> void:
	if not has_been_pressed:
		has_been_pressed=true
		$pressurePlateSprite.play("Press")
