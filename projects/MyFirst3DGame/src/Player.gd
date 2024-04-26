extends CharacterBody3D

signal landed
signal hit

@export var speed = 14 # Speed in m/s
@export var fall_acceleration = 75 # Acceleration in m/s²
@export var jumping_impulse = 20
@export var bounce_impulse = 16

var target_velocity = Vector3.ZERO
var landing = false

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	
	# Facing direction
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.basis = Basis.looking_at(direction)
		# Speed up bouncing while moving
		$AnimationPlayer.speed_scale = 4
	else:
		$AnimationPlayer.speed_scale = 1
	
	# Add speeds
	target_velocity.x =  direction.x * speed
	target_velocity.z =  direction.z * speed
	
	if not is_on_floor():
		target_velocity.y -= fall_acceleration * delta
	
	# Jumping
	if is_on_floor() && Input.is_action_just_pressed("jump"):
		target_velocity.y = jumping_impulse
	
	# Apply speeds
	velocity = target_velocity
	move_and_slide()
	
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		
		if collision.get_collider() == null:
			continue
		
		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				mob.squash()
				target_velocity.y = bounce_impulse
				
				# Prevent duplicate calls within the same frame (landing on 2 simultaneously)
				break
		
		if collision.get_collider().is_in_group("floor"):
			landed.emit()
			break
	
	# Arc hops with ***FANCY MATHS***
	#$Pivot.rotation.x = PI / 6 * velocity.y / jumping_impulse


func die():
	hit.emit()
	queue_free()


func _on_mob_detector_body_entered(body):
	die()
