extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TileMap.visible = false
	$Control.visible = true


func _on_Control_gs():
	$TileMap.visible = true
	$Control.visible = false
