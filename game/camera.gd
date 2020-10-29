extends Camera2D

var rotation_speed_max := 2.0
var rotation_accel_factor := 6.0
var rotation_stop_factor := 3.5

var rotation_speed := 0.0


func _process(delta):
	var wanted_rotation := Input.get_action_strength("go_left") - Input.get_action_strength("go_right")
	relative_rotation(wanted_rotation, delta)


func relative_rotation(force: float, delta: float):
	if abs(force) > 0.001:
		rotation_speed += rotation_accel_factor * force * delta
		rotation_speed = clamp(rotation_speed, -rotation_speed_max, rotation_speed_max)
	else:
		if abs(rotation_speed) < 0.05:
			rotation_speed = 0
		else:
			var deceleration := rotation_speed * rotation_stop_factor * delta
			if sign(rotation_speed) != sign(rotation_speed - deceleration):
				rotation_speed = 0
			else:
				rotation_speed -= deceleration

	rotation += rotation_speed * delta
	rotate_gravity_vector()


func rotate_gravity_vector():
	Physics2DServer.area_set_param(
			get_world_2d().space,
			Physics2DServer.AREA_PARAM_GRAVITY_VECTOR,
			Vector2.DOWN.rotated(rotation))
