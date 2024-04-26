extends CharacterBody3D

signal squashed

@export var min_speed = 10
@export var max_speed = 18

func _physics_process(delta):
	move_and_slide()

func initialize(start_position, player_position):
	look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_y(randf_range(-PI / 4, PI / 4))
	
	var speed = randi_range(min_speed, max_speed)
	velocity = speed * Vector3.FORWARD
	
	velocity = velocity.rotated(Vector3.UP, rotation.y)
	
	#$AnimationPlayer.speed_scale = speed / min_speed


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()


func squash():
	squashed.emit()
	queue_free()
