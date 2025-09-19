extends Node2D

var greenPressurePlatePressed = false
var bluePressurePlatePressed = false
@onready var animated_sprite = $player/AnimatedSprite2D1
@onready var animated_sprite2 = $player2/AnimatedSprite2D2
@onready var bluePressurePlate = $pressureplates/bluepressureplates/bluePressurePlate
@onready var greenPressurePlate = $pressureplates/greenpressureplates/greenPressurePlate
@onready var audioPlayer = $glitchSFX

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if(bluePressurePlatePressed and greenPressurePlatePressed):
		_swap_bodies()

func _swap_bodies():
	audioPlayer.play()
	Global.isGlitching = true
	animated_sprite2.play("Glitch")
	animated_sprite.play("Glitch")
	await animated_sprite2.animation_finished
	if(Global.areSwapped):
		#MAKE GLITCHED MIDDLE INVISIBLE
		Global.areSwapped=false
	else:
		#CHANGE MIDDLE PART OF SCREEN TO GLITCHED
		Global.areSwapped=true
	Global.isGlitching = false
	greenPressurePlatePressed = false
	bluePressurePlatePressed = false

func _on_blue_pressure_plate_body_entered(_body: Node2D) -> void:
	bluePressurePlatePressed = true
	pass

func _on_green_pressure_plate_body_entered(_body: Node2D) -> void:
	greenPressurePlatePressed = true
	pass
