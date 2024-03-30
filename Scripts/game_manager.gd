extends Node
@onready var points_lable = $"../UI/Panel/Points Lable"

var points = 0 

func add_point():
	points += 1
	points_lable.text = "Points: " + str(points)

