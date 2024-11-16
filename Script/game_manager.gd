extends Node

var player_profile : PlayerProfile = PlayerProfile.new()

# complete card configuration list 
@export var card_configuration_list : Array[CardConfiguration] = []

@export var bgm_stream_player : AudioStreamPlayer

func _enter_tree() -> void:
	player_profile.reset_deck()

func _ready() -> void:
	bgm_stream_player.play()

func get_card_configuration(card_id : CardId.Id) -> CardConfiguration :
	for config in card_configuration_list :
		if config.get_id() == card_id :
			return config
	
	return null
