extends Node2D
export(PackedScene) var bullet_scene
var fire_direction =  {'front': Vector2(0,100),
			'back': Vector2(0,-100),
			'left': Vector2(-100,0),
			'right': Vector2(100,0)}
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
	
func _on_KinematicBody2D_fire():
	var bullet = bullet_scene.instance()
	connect("body_entered",bullet,"_on_Bullet_Collide")
	add_child(bullet)
	bullet.position = $KinematicBody2D.position
	bullet$KinematicBody2D/AnimatedSprite.animation
	bullet.move_and_collide(fire_direction[anim])
