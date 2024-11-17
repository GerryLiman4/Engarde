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
	
	SignalManager.add_card_to_deck.emit(card_id)
	current_deck.append(card_id)

func remove_card_from_deck(card_id : CardId.Id) :
	if !current_deck.has(card_id) : return
	
	SignalManager.remove_card_from_deck.emit(card_id)
	current_deck.erase(card_id)
#endregion

#region editing collection
func buy_card_to_collection(card_id : CardId.Id, price : int):
	if current_collection.has(card_id) && current_collection[card_id] == CardId.CardAvailabilityId.OWNED : 
		var notification : BaseNotification = NotificationManager.spawn_base_notification()
		notification.initialize("Already Owned")
		return 
	
	current_money -= price
	current_collection[card_id] = CardId.CardAvailabilityId.OWNED
	
	SignalManager.buy_card_to_deck.emit(card_id)

func sell_card_from_collection(card_id : CardId.Id, price : int) :
	# validation if there is no key in the collection
	if !current_collection.has(card_id) :
		current_collection[card_id] = CardId.CardAvailabilityId.NOT_OWNED
	
	if (current_collection.has(card_id) && current_collection[card_id] == CardId.CardAvailabilityId.NOT_OWNED) : 
		var notification : BaseNotification = NotificationManager.spawn_base_notification()
		notification.initialize("Doesn't Own The Card")
		return 
	
	current_money += price
	current_collection[card_id] = CardId.CardAvailabilityId.NOT_OWNED
	
	# remove in current deck if exist
	if current_deck.has(card_id) : current_deck.erase(card_id)
	
	SignalManager.sell_card.emit(card_id)

#endregion
