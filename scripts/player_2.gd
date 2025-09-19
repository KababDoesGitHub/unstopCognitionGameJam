extends CharacterBody2D

var SPEED = 130.0
const JUMP_VELOCITY = -300.0
var CROUCH_SPEED = 65.0
var jumpCount = 0
var jump="ui_up"
var crouchi="ui_down"
var right="ui_right"
var left="ui_left"

@onready var collisionMask=$CollisionShape2D

var crouchShape = preload("res://crouching.tres")
var standingShape = preload("res://standing.tres")

var is_crouching = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D2

func _ready() -> void:
	collisionMask.position = Vector2(0,-20)
	collisionMask.shape = standingShape

func _physics_process(delta):
	if Input.is_action_just_pressed(crouchi):
		crouch()
	elif Input.is_action_just_released(crouchi):
		stand()
	if Input.is_action_just_pressed(jump) and jumpCount<1:
		jumpCount+=1
		if jumpCount==0:
			if not Global.isGlitching:
				animated_sprite.play("Jump")
		elif jumpCount==1:
			if not Global.isGlitching:
				animated_sprite.play("FrontFlip")
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis(left, right)
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		jumpCount=0
		if direction == 0:
			if is_crouching:
				if not Global.isGlitching:
					animated_sprite.play("Crouch")
			else:
				if not Global.isGlitching:
					animated_sprite.play("Idle")
		else:
			if is_crouching:
				if not Global.isGlitching:
					animated_sprite.play("Crouch")
			else:
				if not Global.isGlitching:
					animated_sprite.play("Run")
	else:
		if(jumpCount==0):
			if not Global.isGlitching:
				animated_sprite.play("Jump")
		velocity.y += gravity * delta
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func crouch():
	if is_crouching:
		return
	is_crouching = true
	collisionMask.shape= crouchShape
	collisionMask.position = Vector2(0,-12)
	if not Global.isGlitching:
		animated_sprite.play("Crouch") 
	SPEED = CROUCH_SPEED

func stand():
	if not is_crouching:
		return
	is_crouching = false
	collisionMask.shape = standingShape
	collisionMask.position = Vector2(0,-20)
	if not Global.isGlitching:
		animated_sprite.play("Idle")
	SPEED = 130.0

func swapped():
	if Global.areSwapped:
		animated_sprite.visible=false
		animated_sprite = $AnimatedSprite2D1
		animated_sprite.visible=true
		jump="jump2"
		crouchi="crouch1"
		right="right2"
		left="left2"
	else:
		animated_sprite.visible=false
		animated_sprite = $AnimatedSprite2D2
		animated_sprite.visible=true
		jump="ui_up"
		crouchi="ui_down"
		right="ui_right"
		left="ui_left"
