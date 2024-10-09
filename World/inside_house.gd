extends Node2D

var entered = false
var outside = "res://World/home.tscn"

func _on_exit_body_entered(body):
	
	if entered:
		get_tree().change_scene_to_file(outside)


func _on_exit_body_exited(body):
	entered = true

