extends Area2D

@onready var timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	body.position=Vector2(0,0)
