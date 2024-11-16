extends Control

class_name CardObjectUI

@export var card_model : TextureRect 
@export var audio_stream_player : AudioStreamPlayer

signal selected(CardObjectUI)

func initialize(configuration : CardConfiguration):
	card_model.texture = configuration.card_image

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.is_action_pressed("click") :
		audio_stream_player.play()
		selected.emit()
