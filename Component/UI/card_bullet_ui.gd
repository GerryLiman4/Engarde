extends Control

class_name CardBulletUI

# type for changing the view
enum TYPE{
	NONE,
	EDIT,
	STORE,
}

@export_category("Buttons")
@export var add_button : Button
@export var remove_button : Button
@export var buy_button : Button
@export var sell_button : Button

@export_category("Section")
@export var card_name : Label
@export var card_description : Label
@export var card_price : Label

var card_configuration : CardConfiguration

signal buy_pressed(CardBulletUI)
signal sell_pressed(CardBulletUI)
signal add_pressed(CardBulletUI)
signal remove_pressed(CardBulletUI)

func initialize(configuration : CardConfiguration) :
	card_configuration = configuration
	

#region buttons


#endregion
