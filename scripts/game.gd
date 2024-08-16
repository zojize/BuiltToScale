extends Node2D

@onready var tile_map_layer = $TileMapLayer
@onready var player = $Player


var initial_screen_size: Vector2i


# Called when the node enters the scene tree for the first time.
func _ready():
	initial_screen_size = get_viewport().size
	print("initial", initial_screen_size)
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
	
	var curr_screen_size = get_viewport().size
	var scale_x = float(curr_screen_size.x) / float(initial_screen_size.x)
	var scale_y = float(curr_screen_size.y) / float(initial_screen_size.y)
	print("scale_x: ", scale_x, ", scale_y: ", scale_y)
	scale_around_origin(tile_map_layer, player.position, Vector2(scale_x * delta, scale_y * delta))
	#print()
	
	pass
