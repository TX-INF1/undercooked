extends RigidBody2D

var picked = false
var player = null
var just_dropped = false
var a = 1 	# way the vector goes, 1 or -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if picked == true:
		self.position = player.get_node("PickUpMarker").global_position
	elif just_dropped:
		if randi() % 2 == 0:
			a = 1
		else:
			a = -1
		self.linear_velocity = Vector2(0,0)
		apply_impulse(Vector2(), Vector2(400 * a,-400))
		self.position[1] -= 15
		self.position[0] -= 15 * a
		just_dropped = false		
		$CollisionShape2D.disabled = false
		$PickArea/CollisionShape2D.disabled = false
		
func _input(event):
	if Input.is_action_just_pressed("interact"):
		if picked:
			# drop
			picked = false
			player = null
			just_dropped = true
		else:
			# pick
			var bodies = $PickArea.get_overlapping_bodies()
			for body in bodies:
				print(body.name)
				if body.name in ["Character1", "Character2"]:
					print(body)
					player = body
			if player != null and player.can_pick:
				picked = true
				$CollisionShape2D.disabled = true
				$PickArea/CollisionShape2D.disabled = true
				
