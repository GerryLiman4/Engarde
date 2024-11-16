extends Object

class_name PlayerProfile

# ceck content, 5 dummy card for starter
var current_deck : Array[CardId.Id] = [
	CardId.Id.MONOKUMA,
	CardId.Id.MARIO,
	CardId.Id.MASTER_CHIEF,
	CardId.Id.JOEL,
	CardId.Id.DRAKE
]

# card id as key , card availability status id as value , EX : { 1  : 0 }
var current_collection : Dictionary = {}

var current_money : int = 3000

func reset_deck():
	current_deck = [
	CardId.Id.MONOKUMA,
	CardId.Id.MARIO,
	CardId.Id.MASTER_CHIEF,
	CardId.Id.JOEL,
	CardId.Id.DRAKE
	]
	
	#populate collection 
	current_collection.clear()
	for card_id in CardId.Id.values() :
		if card_id == CardId.Id.NONE : continue
		current_collection[card_id] = CardId.CardAvailabilityId.OWNED if current_deck.has(card_id) else CardId.CardAvailabilityId.NOT_OWNED

#region editing deck
func add_card_to_deck(card_id : CardId.Id):
	if current_deck.has(card_id) : return
	
	current_deck.append(card_id)

func remove_card_from_deck(card_id : CardId.Id) :
	if !current_deck.has(card_id) : return
	
	current_deck.erase(card_id)
#endregion

#region editing collection

func buy_card_to_collection(card_id : CardId.Id, price : int):
	current_collection[card_id] = CardId.CardAvailabilityId.OWNED

func sell_card_from_collection(card_id : CardId.Id) :
	current_collection[card_id] = CardId.CardAvailabilityId.NOT_OWNED

#endregion
