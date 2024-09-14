extends Node3D

var ball
var ship

var sphere_offset = Vector3(0, -1.5, .5)
var acceleration = 12
var steering = 8
var turn_speed = 4
var turn_stop_limit = 0.75
var body_tilt = 35

var speed_input = 0
var rotate_input = 0

var calibration_offset_x = 0.0
var calibration_offset_y = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ball = $ball
	ship = $ship_dark


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var acc = Input.get_accelerometer()
	
	var adjusted_x = acc.x - calibration_offset_x
	var adjusted_y = acc.y - calibration_offset_y

	var format = "%.05f"
	%AccX.text = format % adjusted_x
	%AccY.text = format % adjusted_y
	%AccZ.text = format % acc.z
	
	if abs(adjusted_x) < 1:
		adjusted_x = 0
	if abs(adjusted_y) < 1:
		adjusted_y = 0
	
	speed_input = 0;
	speed_input += Input.get_action_strength("accelerate")
	speed_input -= Input.get_action_strength("brake")
	speed_input += clamp((acc.y - calibration_offset_y) / 5, -1, 1)
	speed_input *= acceleration
	
	rotate_input = 0;
	rotate_input += Input.get_action_strength("steer_left")
	rotate_input -= Input.get_action_strength("steer_right")
	rotate_input += clamp((acc.x - calibration_offset_x) / 5, -1, 1)
	rotate_input *= deg_to_rad(steering)
	
	
	if ball.linear_velocity.length() > turn_stop_limit:
		var new_basis = ship.global_transform.basis.rotated(ship.global_transform.basis.y, rotate_input)
		ship.global_transform.basis = ship.global_transform.basis.slerp(new_basis, turn_speed * delta)
		ship.global_transform = ship.global_transform.orthonormalized()
		
		var t = -rotate_input * ball.linear_velocity.length() / body_tilt
		#ship.rotation.z = lerp(ship.rotation.z, t, 10* delta)
	

func _input(event):
	# Check for screen touch event
	if event is InputEventScreenTouch and event.is_pressed():
		calibrate()
func calibrate():
	# Set the calibration offsets to the current accelerometer values
	var acc = Input.get_accelerometer()
	calibration_offset_x = acc.x
	calibration_offset_y = acc.y

func _physics_process(delta: float) -> void:
	ship.transform.origin = ball.transform.origin + sphere_offset
	ball.apply_central_force(-ship.global_transform.basis.z * speed_input)
	
	
