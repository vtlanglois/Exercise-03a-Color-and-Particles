extends Node2D

export (String) var color
var is_matched
var is_counted
var selected = false
var target_position = Vector2(0,0)

var dying = false

func _ready():
	pass

func _physics_process(_delta):
	if dying:
		queue_free()
		

func move_piece(change):
	target_position = position + change
	position = target_position

func die():
	dying = true;
