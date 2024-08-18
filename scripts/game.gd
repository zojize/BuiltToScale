extends Node2D

@onready var tile_map_layer = $TileMapLayer
@onready var player = $Player


# var initial_screen_size: Vector2i


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.initial_window_size = get_window().size
	Globals.initial_window_position = get_window().position
	# print("initial", Globals.initial_window_size)
	pass # Replace with function body.

func scale_around_origin(node: Node2D, origin: Vector2, new_scale: Vector2):
	# Calculate the offset from the origin to the node's position
	var offset = node.position - origin
	
	# Calculate the scaled offset
	var scaled_offset = offset * new_scale / node.scale
	
	# Adjust the position to maintain the origin
	node.position = origin + scaled_offset
	
	# Apply the new scale
	node.scale = new_scale

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(get_viewport().size)
	#var t = tile_map_layer.get_transform()
	#t.x.x += 10 * delta
	#tile_map_layer.set_transform(t)
	#player.position
	get_window()
	
	pass


func _on_button_pressed():
	get_window().size = Vector2i(600, 600)
	pass # Replace with function body.
