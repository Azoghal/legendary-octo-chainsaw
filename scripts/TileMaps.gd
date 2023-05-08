extends Node2D

@export var level_size : Vector2

@onready var visible_tm = $VisibleWorld
@onready var seen_tm = $SeenWorld
@onready var source_tm = $SourceWorld



# Called when the node enters the scene tree for the first time.
func _ready():
	set_tiles()
	pass

func set_tiles(player_pos=Vector2i(0,0)):
	var used_cells = source_tm.get_used_cells(0)
	for c in used_cells:
		var atlas_coords = source_tm.get_cell_atlas_coords(0,c)
		#print(atlas_coords)
		if (c-player_pos).length() < 10: # Extend with all visibility granting items
			visible_tm.set_cell(0,c,2,atlas_coords)
			seen_tm.set_cell(0,c,3,atlas_coords)
		else:
			visible_tm.set_cell(0,c)
			#source_tm.set_cell(0,c,-1,atlas_coords)
	#visible_tm.force_update()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
