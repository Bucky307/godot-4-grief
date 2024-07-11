extends CharacterBody2D

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@onready var idleSprite = $IdleSprite
@onready var moveSprite = $MoveSprite
@onready var hitSprite = $HitSprite

func _ready():
	animationTree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)
	
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Move/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Move")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		idleSprite.visible = false
		moveSprite.visible = true
		hitSprite.visible = false
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		idleSprite.visible = true
		moveSprite.visible = false
		hitSprite.visible = false
		
	if Input.is_action_just_pressed("Attack"):
		state = ATTACK
	
	move_and_slide()

func roll_state(delta):
	pass

func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")
	idleSprite.visible = false
	moveSprite.visible = false
	hitSprite.visible = true
	
func attack_animation_finished():
	state = MOVE
	
