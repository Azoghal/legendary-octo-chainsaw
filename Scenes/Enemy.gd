extends Area2D

var tile_size = 16
var moves_per_player_move = 1
var move_budget = 1;
var directions = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}
var directions_i = [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	position = position.snapped(Vector2.ONE * tile_size)

@onready var move_ray = $MoveCollisionRay
@onready var player_ray = $PlayerRay

func inc_budget(player_pos):
	move_budget += 1

func enemy_rogue_move():
	var dir = directions_i[rng.randi_range(0,3)]
	move_ray.target_position = dir*tile_size
	move_ray.force_raycast_update()
	move_budget -= 1
	if !move_ray.is_colliding():
		player_ray.target_position = dir*tile_size
		player_ray.force_raycast_update()
		if player_ray.is_colliding():
			print("resolve attack against player")
		else:
			position += dir * tile_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if move_budget > 0:
		enemy_rogue_move()
