extends Area2D

@onready var animationplayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	queue_free()
