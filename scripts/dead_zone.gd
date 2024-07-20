extends Area2D

# 以手动赋值的方法获取玩家节点的引用，因为玩家不是DeadZone的子节点，所以不要用路径的方式
@export var player:CharacterBody2D
# Timer是DeadZone的子节点，所以可以用路径的方式获取计时器的引用
@onready var restartTimer = $RestartTimer

# 玩家接触到死亡区域后死亡，body指代被碰撞检测到的对象
func _on_body_entered(body):
	# 对玩家调用死亡效果函数
	# 应当用if确保body是CharacterBody2D类型的节点，但我不知如何获取节点类型，暂时懒得搜
	player_death_effect(body)
	# 计时器开始计时（时长可调），结束后重新开始游戏
	restartTimer.start()

# 计时结束的信号函数，即计时结束后需要执行的语句
func _on_timer_timeout():
	# 恢复世界速度
	Engine.time_scale = 1.0
	# get_tree()函数获取当前场景树，然后重新加载该场景
	get_tree().reload_current_scene()

# 玩家的死亡效果
func player_death_effect(body: CharacterBody2D):
	# 死亡瞬间产生整个世界的速度慢下来的效果
	Engine.time_scale = 0.5
	# 移除玩家碰撞箱，使玩家在地面上死亡时产生像马里奥一样掉出世界的效果
	body.get_node("CollisionShape2D").queue_free()
