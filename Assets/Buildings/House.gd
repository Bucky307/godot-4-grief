extends Node2D

@export var inside_scene: PackedScene

func _on_doorway_body_entered(body):
	if body is CharacterBody2D:
		body.set_house(self)

func _on_doorway_body_exited(body):
	if body is CharacterBody2D:
		if body.get_house() == self:
			body.set_house(null)

func enter():
	get_tree().change_scene_to_file(inside_scene.resource_path)
