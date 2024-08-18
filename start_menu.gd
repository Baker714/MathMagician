extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_how_to_play_button_pressed():
	get_tree().change_scene_to_file("res://how_to_play.tscn")

func _on_time_trial_button_pressed():
	get_tree().change_scene_to_file("res://time_trial.tscn")

func _on_casual_mode_button_pressed():
	get_tree().change_scene_to_file("res://casual_mode.tscn")

func _on_quit_game_pressed():
	get_tree().quit()
