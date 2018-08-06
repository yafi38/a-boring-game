extends KinematicBody2D

export (int) var SPEED
export (int) var GRAVITY
export (int) var JUMP

var velocity = Vector2()
var is_jumping = false
var land_pos = 0

func _ready():
	var screensize = get_viewport().size
	pass

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x += SPEED
	if Input.is_action_pressed("ui_left"):
		velocity.x -= SPEED
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -JUMP
			is_jumping = true
		elif is_jumping:
			is_jumping = false
			land_pos = int(position.x/32) - 4
			print(land_pos)
	pass

func _process(delta):
	velocity.y += GRAVITY
	
	get_input()
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	
	if !is_on_floor():
		$AnimatedSprite.animation = "jump"
		$AnimatedSprite.play()
	elif abs(velocity.x) > 0:
		$AnimatedSprite.play()
		$AnimatedSprite.animation = "running"
		$AnimatedSprite.flip_h = velocity.x < 0
	else:
		$AnimatedSprite.stop()
		$AnimatedSprite.animation = "idle"
		
	#position += velocity * delta
	
	pass
