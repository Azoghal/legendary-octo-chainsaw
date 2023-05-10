extends Camera2D

# Define some minimums and maximums
# Define some mappings 

var default_follow
var current_follow 

# Called when the node enters the scene tree for the first time.
func _ready():
	# by default follow the thing that it was originally attached to (the player)
	default_follow = get_parent() 

func switch_follow(new_parent:Node2D, r:int):
	get_parent().remove_child(self)
	current_follow = new_parent
	current_follow.add_child(self)
	position = Vector2.ZERO
	
func remove_follow():
	get_parent().remove_child(self)
	current_follow = default_follow
	current_follow.add_child(self)

func _physics_process(delta):
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#
