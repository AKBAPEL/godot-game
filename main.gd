extends Node2D
export(PackedScene) var bullet_scene
export(PackedScene) var enemy_scene
var score = 0

const speed = 10
var fire_direction =  {'front': Vector2(0,speed),
			'back': Vector2(0,-speed),
			'left': Vector2(-speed,0),
			'right': Vector2(speed,0)}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemy = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$TileMap.visible = false
	$Control.visible = true
	$KinematicBody2D.visible = false
	$Score.visible = false
	$Node2D.visible = false


func _on_Control_gs():
	$TileMap.visible = true
	$Control.visible = false
	$KinematicBody2D.visible = true
	$Score.visible = true
	make_enemy()

func make_enemy():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	while true:
		
		var x = rng.randi_range(2,14) 
		var y = rng.randi_range(2,8) 
		var tile_size = 64
		var half = tile_size / 2
		enemy = enemy_scene.instance()
		enemy.position = Vector2(x * tile_size - half, y * tile_size - half)
		enemy.connect("lose",self,"final")
		if not enemy.test_move(Transform2D(0,enemy.position),Vector2(0,0)):
			add_child(enemy)
			break
		else:
			enemy.queue_free()
	
func _on_KinematicBody2D_fire():
	var bullet = bullet_scene.instance()
	add_child(bullet)
	bullet.connect("hit",self,"on_hit")
	bullet.position = $KinematicBody2D.position
	bullet.direction = fire_direction[$KinematicBody2D/AnimatedSprite.animation]
	
func on_hit():
	score += 1
	$Score/Label2.text = str(score)
	make_enemy()
func _physics_process(delta):
	if enemy:
		var vec = enemy_go()
		enemy.move_and_slide(-vec*50)
	
	
	
	
func enemy_go():
	var speed = 1
	var player = $KinematicBody2D	
	var move = Vector2(enemy.position) - Vector2(player.position)
	return move.normalized()
	
func final():
	$TileMap.visible = false
	$Control.visible = false
	$KinematicBody2D.visible = false
	$Score.visible = false
	$final.visible = true
		
