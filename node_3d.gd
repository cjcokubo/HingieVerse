extends Node3D

# Array to store the nodes
var nodes_to_toggle = []
var current_visible_index = 0

# Reference to the hingeload node
var hingeload_node: Node = null

func _ready():
	# Assign the hingeload node
	hingeload_node = $hingeload
	
	# Add the nodes to the array
	nodes_to_toggle = [
		$rose,
		$like,
		$X,
		$one,
		$two,
		$three
	]
	
	# Ensure only the first node is visible at the start
	for i in range(nodes_to_toggle.size()):
		nodes_to_toggle[i].visible = (i == current_visible_index)
	
	# Ensure hingeload is hidden initially
	hingeload_node.visible = false

func _on_collision() -> void:
	# Hide the current node
	print("Toggling nodes")
	nodes_to_toggle[current_visible_index].visible = false

	# Show the hingeload node
	hingeload_node.visible = true

	# Delay and switch the next node
	await _display_hingeload_and_switch()

func _display_hingeload_and_switch() -> void:
	# Use a timer for the delay
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1.0
	timer.one_shot = true
	timer.start()
	
	await timer.timeout
	
	# Hide the hingeload node after delay
	hingeload_node.visible = false

	# Increment the index and wrap around
	current_visible_index = (current_visible_index + 1) % nodes_to_toggle.size()

	# Show the next node
	nodes_to_toggle[current_visible_index].visible = true
	
	# Clean up the timer
	timer.queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	print("Area entered")
	if body is RigidBody3D or body is XRToolsPickable:
		_on_collision()
		
