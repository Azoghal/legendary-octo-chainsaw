extends TileMap

var aStar:AStar2D

@export var tempLine : PackedScene
@export var tempMarker : PackedScene

var possible_directions = [Vector2i(-1,0),Vector2i(0,1),Vector2i(1,0),Vector2i(0,-1)]

var random = RandomNumberGenerator.new()
var size
var tile_size = 16

# Called when the node enters the scene tree for the first time.
func _ready():
	size = self.get_used_rect().size
	setup_astar()

func setup_astar():
	aStar = AStar2D.new()
	aStar.reserve_space(size.x*size.y)
	print(size.x,size.y)
	for i in size.x:
		for j in size.y:
			var idx = get_a_star_cell_id(Vector2(i,j))
			aStar.add_point(idx, map_to_local(Vector2(i,j)))
	for i in size.x:
		for j in size.y:
			var coords = Vector2i(i,j)
			var id = get_a_star_cell_id(coords)
			var nav_blocking = get_tile_map_nav_blocked(coords)
			if !nav_blocking:
#				var id_marker = tempMarker.instantiate()
#				id_marker.get_node("Label").text = "%d" % [id]
#				id_marker.position = grid_position_to_world_position(coords)
#				get_parent().get_parent().add_child.call_deferred(id_marker)
				for neighbour_offset in possible_directions:
					var neighbour_coords = coords + neighbour_offset
					var neighbour_blocked = get_tile_map_nav_blocked(neighbour_coords)
					if !neighbour_blocked:
						var neighbour_astar = get_a_star_cell_id(neighbour_coords)
						if aStar.has_point(neighbour_astar):
							aStar.connect_points(id, neighbour_astar,false)

func grid_position_to_world_position(coords:Vector2i) -> Vector2:
	var tile_size = 16
	return (coords-size/2)*tile_size
	
func world_position_to_grid_position(coords:Vector2) -> Vector2i:
	var tile_size = 16
	return Vector2i(coords/tile_size) + size/2
	
func grid_position_to_tm_position(coords:Vector2i) -> Vector2i:
	return coords-size/2
	
func tm_position_to_grid_position(coords:Vector2i) -> Vector2i:
	return coords+size/2
	

func get_a_star_path(start_pos:Vector2, target_pos: Vector2)->Array:
	# Argument positions are in world
	
	print(start_pos, target_pos)
	var cell_start = world_position_to_grid_position(start_pos)
	var id_start = get_a_star_cell_id(cell_start)
	var cell_target = world_position_to_grid_position(target_pos)
	var id_target = get_a_star_cell_id(cell_target)
	print(cell_start, cell_target)
	print(id_start, id_target)
	
	var start_marker = tempMarker.instantiate()
	var end_marker = tempMarker.instantiate()
	start_marker.position = start_pos
	end_marker.position = target_pos
	start_marker.get_node("Label").text = "Start"
	end_marker.get_node("Label").text = "End"
	get_parent().get_parent().add_child(start_marker)
	get_parent().get_parent().add_child(end_marker)
	
	if aStar.has_point(id_start) and aStar.has_point(id_target):
		var path = Array(aStar.get_point_path(id_start, id_target))
		print(path)
		var path2 = path.map(func(x):return x - Vector2((size/2)*tile_size))
		print(path2)
		var line = tempLine.instantiate()
		line.points = path2
		get_parent().add_child(line)
		return path
	return []


func get_tile_map_nav_blocked(coords:Vector2i)->bool:
	var cell_temp = get_cell_tile_data(0, coords-size/2)
	var nav_blocking = false
	if cell_temp:
		# update to true if its a nav blocker
		nav_blocking = cell_temp.get_custom_data("NavBlocked")
	return nav_blocking
	
func get_a_star_cell_id(v_cell: Vector2)-> int:
	# Id column major top left to bottom right
	return int(v_cell.y + v_cell.x*self.get_used_rect().size.y)

func occupy_a_star_cell(pos):
	#https://escada-games.itch.io/randungeon/devlog/261991/how-to-use-godots-astar2d-for-path-finding
	# might need to global/local adjust pos
	var cell_coord = local_to_map(pos)
	var cell_id = get_a_star_cell_id(cell_coord)
	if aStar.has_point(cell_id):
		aStar.set_point_disabled(cell_id,true)
		
func free_a_star_cell(pos):
	# might need to global/local adjust pos
	var cell_coord = local_to_map(pos)
	var cell_id = get_a_star_cell_id(cell_coord)
	if aStar.has_point(cell_id):
		aStar.set_point_disabled(cell_id,false)

func _unhandled_input(event):
	if event.is_action_pressed("Rest"):
		var size = self.get_used_rect().size
		print(size)
		var start_loc = get_global_mouse_position()
		start_loc = start_loc.snapped(Vector2.ONE * 16)
		# var start_loc = Vector2(random.randi_range(0,size.x-1),random.randi_range(0,size.y-1))
		var end_loc = Vector2(0,0)
		print("start:",start_loc)
		print("end:", end_loc)
		get_a_star_path(start_loc, end_loc)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
