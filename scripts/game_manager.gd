extends Node

# 记录玩家的分数
var score :int = 0
# 显示玩家分数的Label
@onready var score_label = $ScoreLabel

# 拾取金币而增加得分的函数
func increase_score_by(adder: int):
	score += adder
	# 每次增加分数时更新这段文字
	score_label.text = "You've earned " + str(score) + " scores!"
