extends Node2D

@export var level_size : Vector2

@onready var visible_tm = $VisibleWorld
@onready var seen_tm = $SeenWorld
@onready var source_tm = $SourceWorld


var visibility_ranges = {}

#var player_range = 10
#var player: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var GameManager = get_parent()
	var player = get_tree().get_nodes_in_group("Player")[0]
	player.new_visibility.connect(add_visibility)
	player.update_visibility.connect(update_visibility)
	GameManager.new_visibility.connect(add_visibility)
	GameManager.remove_visibility.connect(remove_visibility)
	GameManager.update_visibility.connect(update_visibility)
	call_deferred("set_tiles")
	
func add_visibility(n2d, r):
	visibility_ranges[n2d] = r
	set_tiles()
	
func remove_visibility(n2d):
	visibility_ranges.erase(n2d)
	set_tiles()
	
func update_visibility(n2d, r):
	visibility_ranges[n2d] = r
	set_tiles()

func set_tiles(player_pos=Vector2i(0,0)):
	var used_cells = source_tm.get_used_cells(0)
	for c in used_cells:
		var atlas_coords = source_tm.get_cell_atlas_coords(0,c)
		#print(atlas_coords)
		visible_tm.set_cell(0,c)
		for k in visibility_ranges:
			var v = visibility_ranges[k]
			var tile_pos = Vector2i(k.position/16)
			if (c-tile_pos).length() < v: # Extend with all visibility granting items
				# raycast for visibility?
				visible_tm.set_cell(0,c,2,atlas_coords)
				seen_tm.set_cell(0,c,3,atlas_coords)
				#source_tm.set_cell(0,c,-1,atlas_coords)
	#visible_tm.force_update()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
