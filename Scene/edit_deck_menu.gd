extends Control

func _on_edit_deck_popup_menu_exit_popup() -> void:
	await SceneHandler.load_scene_by_path(SceneHandler.scene_list.MainMenu)
