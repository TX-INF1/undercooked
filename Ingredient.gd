extends Item
class_name Ingredient

var wokResult: String = "none"
var boilResult: String = "none"
var chopResult: String = "none"
var itemType: String = "none"
var originBox: Box = null
var regenerated: bool = false

func setup(type: String, init_position: Vector2, box: Box):
	position = init_position
	originBox = box
	dish = false
	itemType = type
	if itemType == "apple":
		$Sprite.play("apple")
		chopResult = "choppedApple"
	elif itemType == "banana":
		$Sprite.play("banana")
		chopResult = "choppedBanana"
	else:
		printerr("Error : the type provided is not supported.")
	
func _process(_delta):
	if just_picked and not regenerated:
		originBox.cool_down()
		regenerated = true
	super._process(_delta)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


