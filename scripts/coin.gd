extends Area2D

# 获取GameManager的引用，以使得拾取金币能增加得分
@onready var game_manager = %GameManager
# 获取动画播放器，用于播放拾取金币的动画
@onready var animation_player = $AnimationPlayer

# 当有对象与coin发生碰撞的时候执行这个信号函数
func _on_body_entered(body):
	# 调用GameManager进行分数的增加
	game_manager.increase_score_by(1)
	# 调用拾取金币的动画，包含播放音效，在一段时间后会自动调用queue_free()函数删除该金币
	animation_player.play("pick_up")
	
	# 删除这个coin对象
	# queue_free()
