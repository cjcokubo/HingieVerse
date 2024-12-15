extends MeshInstance3D

var amplitude = 0.1  # How far it moves
var speed = 4.0      # How fast it moves
var base_position = Vector3()  # Stores the starting position
var time_passed = 0.0  # Tracks time

func _ready():
	base_position = position  # Save the original position

func _process(delta):
	# Increment time based on delta
	time_passed += delta

	# Create a bobbing motion using the sine function
	position.y = base_position.y + sin(time_passed * speed) * amplitude
