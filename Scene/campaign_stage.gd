extends Node2D

@export var deck_object : DeckObject
@export var discarded_root : Node2D
@export var shop_root : Node2D
@export var card_object_prefab : PackedScene

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
	SignalManager.buy_card_to_deck.connect(on_buy_card_to_deck)
	SignalManager.sell_card.connect(on_sell_card)

func _on_exit_button_pressed() -> void:
	SceneHandler.load_scene_by_path(SceneHandler.scene_list.MainMenu)

func do_zoom_out():
	var tween = get_tree().create_tween()
	tween.tween_property(camera, "zoom", Vector2(1.0,1.0), 0.75).set_trans(Tween.TRANS_SINE)

func _on_deck_root_selected() -> void:
	edit_popup.open_popup()

#region transaction
func on_add_card_to_deck(card_id : CardId.Id):
	for card in discarded_root.get_children() :
		if card is CardObject :
			if card.card_configuration.get_id() == card_id :
				#change to animation
				deck_object.add_card_by_object(card)
				await move_card(card,deck_object.global_position)

func on_remove_card_from_deck(card_id : CardId.Id):
	var card_object : CardObject = deck_object.remove_card(card_id)
	#change to animation
	if card_object == null : return
	
	await move_card(card_object,discarded_root.global_position)
	card_object.reparent(discarded_root)

func on_buy_card_to_deck(card_id : CardId.Id):
	var card_object : CardObject = card_object_prefab.instantiate()
	card_object.initialize(GameManager.get_card_configuration(card_id))
	shop_root.add_child(card_object)
	
	await get_tree().physics_frame
	deck_object.add_card_by_object(card_object)
	
	#change to animation
	await move_card(card_object,deck_object.global_position)

func on_sell_card(card_id : CardId.Id):
	# check if the card exist on the deck
	var card_object : CardObject = deck_object.remove_card(card_id)
	
	# check on discarded field
	if card_object == null : 
		for discarded_card in discarded_root.get_children() :
			if discarded_card is CardObject : 
				if discarded_card.card_configuration.get_id() == card_id :
					card_object = discarded_card
					break
	
	if card_object == null : return
	
	#change to animation
	await move_card(card_object,shop_root.global_position)
	card_object.queue_free()

#endregion

#region animation

func move_card(card : CardObject , designated_position : Vector2, time : float = 0.05):
	var tween = get_tree().create_tween()
	tween.tween_property(card, "global_position",designated_position, time).set_trans(Tween.TRANS_SINE)
	await tween.finished

#endregion
