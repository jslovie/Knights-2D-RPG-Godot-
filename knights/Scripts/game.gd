extends Node2D

func _process(delta):
	change_scene()

func _on_leftside_transition_point_body_entered(body):
	if  body.has_method("player"):
		global.transition_scene = true
		

func _on_leftside_transition_point_body_exited(body):
	if  body.has_method("player"):
		global.transition_scene = false


func change_scene():
	if global.transition_scene == true:
		if global.current_scene == "game":
			get_tree().change_scene_to_file("res://Scenes/left_side.tscn")
			global.finish_changescenes()
