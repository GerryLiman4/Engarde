extends Object

class_name PlayerProfile

# card id as key , card amount as value , EX : { 1 : 3 }
var current_deck : Dictionary = {}

# card id as key , card availability status id as value , EX : { 1  : 0 }
var current_collection : Dictionary = {}

var current_money : int = 3000

func reset_deck():
	current_deck = {}
