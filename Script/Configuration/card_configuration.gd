extends Resource

class_name CardConfiguration

@export var card_id : CardId.Id = CardId.Id.NONE
@export var card_name : String = ""
@export var description : String = ""
@export var card_image : Texture2D 
@export var card_price : int = 200

func get_id() -> CardId.Id:
	return card_id
