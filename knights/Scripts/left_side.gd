extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	change_scenes()


func _on_exit_body_entered(body):
	if body.has_method("player"):
		global.transition_scene = true
		print("trans")
		



func change_scenes():
	if global.transition_scene == true:
		if  global.current_scene == "left_side":
			get_tree().change_scene_to_file("res://Scenes/game.tscn")
			global.finish_changescenes()
