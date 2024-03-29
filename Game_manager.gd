extends Node

var repas_faits = 0
var dishes_to_make = { "Carrot-Tomato-Zucchini Salad" : 2 , "Tomato-Carrot Noodles" : 3, "Eggplant-Zucchini Noodles" :2, "Tomato-Zucchini Noodles" : 1} 

@onready var label = $"../conveyer_belt/UI/Panel/Label"
var victory: bool = false
signal victory_signal

func add_dish(name):
	if name in dishes_to_make and dishes_to_make[name] > 0 :
		dishes_to_make[name] -= 1
		var text=""
		for plate in dishes_to_make:
			text+= str( "Number of", plate , " to do : " , dishes_to_make[plate], "    |   ")
		label.text=text
		repas_faits +=1
		check_win_condition()



# Called when the node enters the scene tree for the first time.
func _ready():
	var text = ""
	for plate in dishes_to_make:
		text+= str("Number of " , plate , " to do : " , dishes_to_make[plate], "    |   ")
		label.text=text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed('reset'):
			get_tree().reload_current_scene()
	
	
func check_win_condition():
	victory = true
	for plate in dishes_to_make:
		if dishes_to_make[plate] > 0 :
			victory = false
	if victory:
		label.text = "Congratulations, press p to restart"
		victory_signal.emit()
