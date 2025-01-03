extends Node

signal notification_confirm()
signal remove_card_from_deck(card_id : CardId.Id)
signal add_card_to_deck(card_id : CardId.Id)
signal buy_card_to_deck(card_id : CardId.Id)
signal sell_card(card_id : CardId.Id)
