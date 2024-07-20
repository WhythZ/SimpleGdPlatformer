extends Node2D

# 史莱姆的移动速度
@export var moveSpeed: float = 60
# 史莱姆的移动朝向（1右/-1左），默认向右
var facingDir := 1
# 向左和向右的射线检测是否碰到墙壁（由于其他装饰物没有碰撞箱，所以不会误触）
@onready var raycast_right = $RayCast2D_Right
@onready var raycast_left = $RayCast2D_Left
# 获取怪物AnimatedSprite2D的引用，用于Flip怪物的Sprite
@onready var anim = $AnimatedSprite2D

# 与Unity的Update()函数相似，delta是单位时间
func _process(delta):
	# 向右的射线与墙壁发生碰撞则史莱姆向左转，反之向右转
	if raycast_right.is_colliding():
		facingDir = -1
		# 翻转Sprite
		anim.flip_h = true
	if raycast_left.is_colliding():
		facingDir = 1
		anim.flip_h = false		
	# 怪物的位移，位移量必须要乘上deltatime
	position.x += facingDir * moveSpeed * delta
