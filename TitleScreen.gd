extends Control

func _ready():
	pass


func _on_play_pressed():
	get_tree().change_scene_to_file("res://MainGame.tscn")

func _on_options_pressed():
	# Handle options button press
	pass

func _on_credits_pressed():
	# Handle credits button press
	pass
