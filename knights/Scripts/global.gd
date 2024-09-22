extends Node

var player_current_attack = false

var current_scene = "game"
var transition_scene = false

var player_exit_left_posx = 0
var player_exit_left_posy = 0

var player_start_posx = 0
var player_start_posy = 0

func finish_changescenes():
	if transition_scene == true:
		transition_scene == false
		if current_scene == "game":
			current_scene = "left_side"
		else:
			current_scene = "game"
