extends Sprite2D

var speed = 400
var angular_speed = PI

func _ready():
	var timer = get_node("Timer")
	timer.timeout.connect(_on_timer_timeout)

func _process(delta):
	rotation += angular_speed * delta
	
	var velocity = Vector2.UP.rotated(rotation) * speed
	
	position += velocity * delta

# Used for Signals
func _on_button_pressed():
	set_process(not is_processing())

func _on_timer_timeout():
	visible = not visible
	
# Further Reading
#https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html#custom-signals
