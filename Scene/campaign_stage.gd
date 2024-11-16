extends Node2D

@export var deck_object : DeckObject
@export var discarded_root : Node2D
@export var main_canvas : CanvasLayer
@export var camera : Camera2D

@export_category("Popup")
@export var edit_popup : GeneralPopupMenu

func _ready() -> void:
	deck_object.initialize(GameManager.player_profile.current_deck)
	do_zoom_out()

func _on_exit_button_pressed() -> void:
	SceneHandler.load_scene_by_path(SceneHandler.scene_list.MainMenu)

func do_zoom_out():
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "zoom", Vector2(1.0,1.0), 0.75).set_trans(Tween.TRANS_SINE)

func _on_deck_root_selected() -> void:
	print("Open")
	edit_popup.open_popup()
