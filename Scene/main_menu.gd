extends Node2D

#region navigation

func _on_start_button_pressed() -> void:
	pass # Replace with function body.

func _on_edit_button_pressed() -> void:
	await SceneHandler.load_scene_by_id(SceneHandler.scene_list.find_key(SceneHandler.scene_list.EditDeck))

func _on_exit_button_pressed() -> void:
	get_tree().quit()

#endregion
