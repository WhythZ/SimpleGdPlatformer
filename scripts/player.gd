extends CharacterBody2D

# 玩家的移动速度与跳跃力度
@export var moveSpeed: float = 300.0
@export var jumpForce: float = -400.0
# 玩家重力，默认为系统提供的数值
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# 储存玩家的动画机
@onready var anim = $AnimatedSprite2D
# 玩家的朝向，0代表静止
var direction: int = 0

# 类似_process(delta)更新函数，此函数更适合物理体的更新
func _physics_process(delta):
	# 玩家不在地面上时，应用重力
	if not is_on_floor():
		velocity.y += gravity * delta

	# 玩家的按键控制
	player_input_keybinding()
	#玩家的动画控制
	player_animation_controller()

	move_and_slide()

# 玩家的按键控制函数
func player_input_keybinding():
	# 跳跃动作，通过设置中的"jump"动作绑定的按键触发，并要求玩家在地面上
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpForce

	# 左右移动动作，通过设置中的"move_left"与"move_right"动作绑定的按键触发
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * moveSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, moveSpeed)

# 玩家的动画控制
func player_animation_controller():
	# 玩家的转向需要翻转Sprite
	player_flip_controller()
	
	# 在地上时，播放玩家的闲置或移动动画
	if is_on_floor():
		if direction == 0:
			anim.play("idle")
		else:
			anim.play("move")
	else:
		# 不在地上时播放玩家的跳跃动画
		anim.play("jump")

# 玩家的转向控制
func player_flip_controller():
	if direction > 0:
		anim.flip_h = false
	elif direction < 0:
		anim.flip_h = true
