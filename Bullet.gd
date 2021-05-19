extends Area2D

var direction = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direction:
		position += direction
	



func _on_Area2D_body_entered(body):
	if body.is_in_group("wall"):
		queue_free()
	elif body.is_in_group("Enemy"):
		emit_signal("hit")
		body.queue_free()
		#disconnect("hit",$"../)
		queue_free()
