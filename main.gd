extends Node

## Constants
#const TILT_THRESHOLD = 1.0  # Minimum tilt needed to rotate the boat
#const MAX_SPEED = 10.0  # Max speed of the boat
#const TURN_SPEED = 2.0  # Speed at which the boat rotates (in radians per second)
#const CAMERA_DISTANCE = 10.0  # Distance of the camera behind the boat
#const CAMERA_HEIGHT = 5.0  # Height of the camera relative to the boat
#const CAMERA_SMOOTHNESS = 0.1  # Smoothness factor for the camera's movement
#
## Variables for calibration offsets
#var calibration_offset_x = 0.0
#var calibration_offset_y = 0.0
#
## Variables for boat movement
#var speed = 0.0  # Current speed of the boat
#var rotation_speed = 0.0  # Current rotation speed of the boat
#
## References to the boat and camera nodes
#var boat
#var camera
#
#func _ready():
	## Enable input event processing
	#set_process_input(true)
	#
	## Assume the boat is a child node of this script's node
	#boat = $ship_dark  # Replace 'Boat' with the actual node name of your boat if different
	#camera = $Camera3D  # Replace 'Camera' with the actual node name of your camera if different
#
#func _input(event):
	## Check for screen touch event
	#if event is InputEventScreenTouch and event.is_pressed():
		#calibrate()
#
#func calibrate():
	## Set the calibration offsets to the current accelerometer values
	#var acc = Input.get_accelerometer()
	#calibration_offset_x = acc.x
	#calibration_offset_y = acc.y
#
#func _process(delta):
	#var acc = Input.get_accelerometer()
	#
	## Adjust accelerometer values based on calibration
	#var adjusted_x = acc.x - calibration_offset_x
	#var adjusted_y = acc.y - calibration_offset_y
#
	#var format = "%.05f"
	#%AccX.text = format % adjusted_x
	#%AccY.text = format % adjusted_y
	#%AccZ.text = format % acc.z
#
	## Update rotation speed based on the adjusted x value (tilt left or right)
	#if abs(adjusted_x) > TILT_THRESHOLD:
		#rotation_speed = -adjusted_x * TURN_SPEED  # Negative for right tilt, positive for left tilt
	#else:
		#rotation_speed = 0.0
#
	## Update speed based on the adjusted y value (tilt forward or backward)
	#if abs(adjusted_y) > TILT_THRESHOLD:
		#speed = -adjusted_y * MAX_SPEED  # Negative because positive y tilt is backward in your setup
	#else:
		#speed = 0.0  # No forward or backward movement if within tilt threshold
#
	## WASD keyboard controls for testing
	#if Input.is_action_pressed("move_forward"):  # W key
		#speed = MAX_SPEED
	#elif Input.is_action_pressed("move_backward"): # S key
		#speed = -MAX_SPEED
	#else:
		#speed = 0.0
#
	#if Input.is_action_pressed("move_left"):  # A key
		#rotation_speed = TURN_SPEED
	#elif Input.is_action_pressed("move_right"):  # D key
		#rotation_speed = -TURN_SPEED
	#else:
		#rotation_speed = 0.0
#
	## Rotate the boat based on the rotation speed
	#boat.rotate_y(rotation_speed * delta)  # Rotate the boat around the Y-axis
#
	## Create a forward vector based on the boat's current rotation
	#var forward_vector = -boat.transform.basis.z  # The forward direction of the boat
#
	## Calculate the movement vector
	#var movement_vector = forward_vector * speed * delta
#
	## Update boat position
	#boat.translate(movement_vector)
#
	## Update camera position to follow the boat
	#update_camera(delta)
#
#func update_camera(delta):
	## Target position for the camera (behind and above the boat)
	#var target_position = boat.global_transform.origin - boat.transform.basis.z * CAMERA_DISTANCE + Vector3(0, CAMERA_HEIGHT, 0)
	#
	## Smooth camera movement using lerp
	#camera.global_transform.origin = camera.global_transform.origin.lerp(target_position, CAMERA_SMOOTHNESS)
	#
	## Ensure the camera is always looking at the boat
	#camera.look_at(boat.global_transform.origin, Vector3.UP)
