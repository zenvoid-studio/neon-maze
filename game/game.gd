extends Node2D


func _ready():
	$Camera.position = $Character.position

func _process(delta):
	var offset: Vector2 = $Character.position - $Camera.position
	$Camera.position += offset * delta * 9
