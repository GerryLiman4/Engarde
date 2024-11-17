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
	
	# connect all signal
	SignalManager.add_card_to_deck.connect(on_add_card_to_deck)
	SignalManager.remove_card_from_deck.connect(on_remove_card_from_deck)

func _on_exit_button_pressed() -> void:
	SceneHandler.load_scene_by_path(SceneHandler.scene_list.MainMenu)

func do_zoom_out():
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "zoom", Vector2(1.0,1.0), 0.75).set_trans(Tween.TRANS_SINE)

func _on_deck_root_selected() -> void:
	edit_popup.open_popup()

func on_add_card_to_deck(card_id : CardId.Id):
	for card in discarded_root.get_children() :
		if card is CardObject :
			if card.card_configuration.get_id() == card_id :
				card.global_position = deck_object.global_position
				deck_object.add_card_by_object(card)

func on_remove_card_from_deck(card_id : CardId.Id):
	var card_object : CardObject = deck_object.remove_card(card_id)
	card_object.global_position = discarded_root.global_position
	card_object.reparent(discarded_root)
