extends Node2D

@export var torch: PackedScene;
var tm

signal new_visibility(Node2D, int)
signal remove_visibility(Node2D)
signal update_visibility(Node2D, int)

func _ready():
	pass
	
func _unhandled_input(event):
	pass
# 	if event.is_action("windowSizeXDec"):
#		var t = torch.instantiate()
#		add_child(t)
#		t.position = Vector2(96,0)
#		print(t.name)
#		print(t.position)
#		new_visibility.emit(t, 10)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
