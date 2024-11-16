extends Node2D

class_name CardObject

@export var model : Sprite2D

var card_configuration : CardConfiguration

func initialize(configuration : CardConfiguration):
	card_configuration = configuration
	model.texture = card_configuration.card_image
