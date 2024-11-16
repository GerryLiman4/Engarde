extends Node2D

class_name DeckObject

@export var card_object_prefab : PackedScene
@export var audio_stream_player : AudioStreamPlayer

var card_object_list : Array[CardObjectUI] = []

signal selected()

func initialize(starter_cards : Array[CardId.Id]):
	for card_id in starter_cards :
		var card_object : CardObject = card_object_prefab.instantiate()
		card_object.initialize(GameManager.get_card_configuration(card_id))
		call_deferred("add_child",card_object)

func _on_hitbox_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton && event.is_action_pressed("click") :
		audio_stream_player.play()
		selected.emit()

func _on_hitbox_mouse_entered() -> void:
	pass # Replace with function body.

func _on_hitbox_mouse_exited() -> void:
	pass # Replace with function body.
