extends Node2D

var greenPressurePlatePressed = false
var bluePressurePlatePressed = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(bluePressurePlatePressed and greenPressurePlatePressed):
		get_tree().change_scene_to_file("res://scenes/level_successful.tscn")

func _on_blue_pressure_plate_body_entered(body: Node2D) -> void:
	bluePressurePlatePressed = true
	pass

func _on_green_pressure_plate_body_entered(body: Node2D) -> void:
	greenPressurePlatePressed = true
	pass
