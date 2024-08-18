extends StaticBody2D

var texture_size: Vector2
var initial_scale: Vector2
var initial_global_position: Vector2

@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D

enum Direction {
	UP = 1 << 0,
	DOWN = 1 << 1,
	LEFT = 1 << 2,
	RIGHT = 1 << 3
}

@export var initial_size: Vector2 = Vector2(20, 20)
@export var min_size: Vector2 = Vector2(10, 10)
@export var max_size: Vector2 = Vector2(50, 50)
@export_flags("UP:1", "DOWN:2", "LEFT:4", "RIGHT:8") var limits: int = 0


func scale_around_origin(node: Node2D, origin: Vector2, new_scale: Vector2):
	var offset = node.position - origin
	var scaled_offset = offset * new_scale / node.scale
	node.position = origin + scaled_offset
	node.scale = new_scale



func set_block_size(size: Vector2):
	# return
	# print("set_block_size", size, grow_direction)
	collision_shape.shape.size = size
	sprite.scale = size

func expand_block(size: Vector2, expand_direction: Direction):

	if limits & expand_direction:
		return

	var prev_size = collision_shape.shape.size
	var new_size = prev_size + size
	
	new_size.x = clamp(new_size.x, min_size.x, max_size.x)
	new_size.y = clamp(new_size.y, min_size.y, max_size.y)
	
	set_block_size(new_size)

	size.x = new_size.x - prev_size.x
	size.y = new_size.y - prev_size.y

	if expand_direction & Direction.RIGHT:
		global_position.x += size.x / 2
	if expand_direction & Direction.LEFT:
		global_position.x -= size.x / 2
	if expand_direction & Direction.UP:
		global_position.y -= size.y / 2
	if expand_direction & Direction.DOWN:
		global_position.y += size.y / 2


var last_window_size := Vector2i(-1, -1)
var last_window_position := Vector2i(-1, -1)

func on_resize():
	# print("on_resize")

	var flag := 0
	var window := get_window()
	var window_size := window.size
	var window_position := window.position

	if last_window_size == Vector2i(-1, -1):
		last_window_size = window_size
		last_window_position = window_position
		return

	
	# var diff = Vector2(window_size - Globals.initial_window_size) / 2
	var diff = Vector2(window_size - last_window_size) / 2
	last_window_size = window_size
	last_window_position = window_position

	# print(get_global_mouse_position())
	var mouse_position = get_viewport().get_mouse_position()

	var sflag := ""

	# if Globals.initial_window_size.x != window_size.x:
	# 	if Globals.initial_window_position.x > window_position.x and last_window_position.x > window_position.x:
	# 		flag |= Direction.LEFT
	# 		sflag += "LEFT"
	# 	else:
	# 		flag |= Direction.RIGHT
	# 		sflag += "RIGHT"

	# if Globals.initial_window_size.y != window_size.y:
	# 	if Globals.initial_window_position.y > window_position.y and last_window_position.y > window_position.y:
	# 		flag |= Direction.UP
	# 		sflag += "UP"
	# 	else:
	# 		flag |= Direction.DOWN
	# 		sflag += "DOWN"
	# print(window_size)
	const tol = 20
	if abs(mouse_position.x) < tol:
		flag |= Direction.LEFT
		sflag += "LEFT"
	if abs(mouse_position.x - window_size.x) < tol:
		flag |= Direction.RIGHT
		sflag += "RIGHT"
	if abs(mouse_position.y + 42) < tol:
		flag |= Direction.UP
		sflag += "UP"
	if abs(mouse_position.y - window_size.y) < tol:
		flag |= Direction.DOWN
		sflag += "DOWN"

	# if Globals.initial_window_size.y != window_size.y:
	# 	if Globals.initial_window_position.y > window_position.y and last_window_position.y > window_position.y:
	# 		flag |= Direction.UP
	# 		sflag += "UP"
	# 	else:
	# 		flag |= Direction.DOWN
	# 		sflag += "DOWN"
	print("flag: ", flag, ", sflag: ", sflag)
	# set_block_size(initial_size + diff, flag)
	expand_block(diff, flag)
	pass
	

# Called when the node enters the scene tree for the first time.
func _ready():
	texture_size = sprite.texture.get_size()
	initial_global_position = global_position
	print("initial_global_position: ", initial_global_position)
	# print(get_window().size)
	get_window().size = Vector2(600, 600)
	
	set_block_size(initial_size)
	get_tree().get_root().size_changed.connect(on_resize)
	
	# set_block_size(Vector2(30, 30))
	

var temp = Vector2(30, 30)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(get_viewport().get_mouse_position())
	# print(get_local_mouse_pos())
	# temp.x += delta
	# set_block_size(temp, Direction.RIGHT)
	# var curr_screen_size = get_window().size
	# var scale_x = float(curr_screen_size.x) / float(Globals.initial_window_size.x)
	# var scale_y = float(curr_screen_size.y) / float(Globals.initial_window_size.y)
	# # print("scale_x: ", scale_x, ", scale_y: ", scale_y)
	# scale_around_origin(self, position, Vector2(scale_x, scale_y))
	pass

