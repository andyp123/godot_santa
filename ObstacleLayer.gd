extends Node2D

export var obstacle_resources = StringArray()
var obstacle_objects = []

export var spawn_delay = 3.0 # should really be based on distance
var accum = 0.0

var total_distance = 0.0
var next_spawn_distance = 300.0

func _ready():
	for resource_name in obstacle_resources:
		var resource_path = "res://" + resource_name + ".tscn"
		var obstacle = load(resource_path)
		if obstacle != null:
			obstacle_objects.append(obstacle)
		else:
			print("could not load resource: %s" % resource_path)

	set_process(true)

func _process(delta):
	if total_distance >= next_spawn_distance:
		if obstacle_objects.size() > 0:
			var idx = rand_range(0, obstacle_objects.size())
			var obstacle = obstacle_objects[idx].instance()
			add_child(obstacle)
			obstacle.set_pos(Vector2(1280.0, 720.0 + rand_range(0, 10))) # FIXME: magic number
		next_spawn_distance = total_distance + 600.0 + rand_range(-100, 100)

func spawn_obstacle():
	pass

func update_obstacles(distance):
	total_distance += distance
	for obstacle in get_children():
		# kill obstacle if it has scrolled off the left side
		
		# update obstacle position
		var pos = obstacle.get_pos()
		pos.x -= distance
		obstacle.set_pos(pos)
