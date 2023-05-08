extends Area2D

# We allow grid movement
# We signal to enemies when we move for roguelikes

signal player_moved(Vector2i)
var move_budget = 2


var tile_size = 16
var inputs = {
	"MoveRight": Vector2.RIGHT,
	"MoveLeft": Vector2.LEFT,
	"MoveUp": Vector2.UP,
	"MoveDown": Vector2.DOWN
}

# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * tile_size)

@onready var move_ray = $MovementCollisionRay
@onready var enemy_ray = $EnemyRay

func rogue_move(direction):
	move_ray.target_position = inputs[direction]*tile_size
	move_ray.force_raycast_update()
	if !move_ray.is_colliding():
		enemy_ray.target_position = inputs[direction]*tile_size
		enemy_ray.force_raycast_update()
		if enemy_ray.is_colliding():
			resolve_rogue_attack(enemy_ray.get_collider())
		else:
			position += inputs[direction] * tile_size
		player_moved.emit(Vector2i(position/16))
	else:
		print("blocked by %s" % move_ray.get_collider().name)

func resolve_rogue_attack(enemy_collider):
	print("Resolve an attack made against %s" % enemy_collider.name)

func _unhandled_input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			rogue_move(dir)
	if event.is_action_pressed("Rest"):
		player_moved.emit(Vector2i(position/16))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
