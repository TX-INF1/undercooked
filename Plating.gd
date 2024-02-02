extends RigidBody2D
class_name Plating

var capacity: int = 3
var used_slots: int = 0
var playerUser: CharacterBody2D = null
var lastIngredient: Ingredient = null
var ingredient_types: Array[String] = []
var full = false
var resultType: String = ""

const recipes = {
	["cookedEggplant", "cookedEggplant", "cookedEggplant"] : "moussaka",
	["choppedCarrot", "choppedTomato", "choppedZucchini"]: "salad",
	["boiledNoodles", "cookedCarrot", "cookedTomato"] : "noodles1",
	["boiledNoodles", "cookedEggplant", "cookedZucchini"] : "noodles2",
	["boiledNoodles", "cookedTomato", "cookedZucchini"] : "noodles3",
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(_event):
	if Input.is_action_just_pressed("interact_1"):
		var bodies = $UseArea.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Character1":
				playerUser = body
		if playerUser != null and not playerUser.can_pick:
			var area = $UseArea.get_overlapping_areas()
			if area :
				lastIngredient = area[0].get_parent()
				ingredient_types.append(lastIngredient.itemType)
				lastIngredient.queue_free()
				playerUser.can_pick = true
				used_slots += 1
			if used_slots == capacity:
				plating()
	if Input.is_action_just_pressed("interact_2"):
		var bodies = $UseArea.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Character2":
				playerUser = body
		if playerUser != null and not playerUser.can_pick:
			var area = $UseArea.get_overlapping_areas()
			if area :
				lastIngredient = area[0].get_parent()
				ingredient_types.append(lastIngredient.itemType)
				lastIngredient.queue_free()
				playerUser.can_pick = true
				used_slots += 1
			if used_slots == capacity:
				plating()

func plating():
	ingredient_types.sort()
	if ingredient_types in recipes.keys():
		resultType = recipes[ingredient_types]
	else:
		resultType = "coal"
	get_parent().spawn_ingredient(resultType, global_position, null)
	
	
