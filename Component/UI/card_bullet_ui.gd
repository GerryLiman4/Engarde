extends Control

class_name CardBulletUI

# type for changing the view
enum TYPE{
	NONE,
	EDIT,
	STORE,
}

@export var current_view_type : TYPE = TYPE.NONE
@export var button_options : Control

@export_category("Buttons")
@export var add_button : Button
@export var remove_button : Button
@export var buy_button : Button
@export var sell_button : Button

@export_category("Section")
@export var card_object_ui : CardObjectUI
@export var card_name : Label
@export var card_description : Label
@export var card_price : Label
@export var card_status_label : Label

var card_configuration : CardConfiguration
var card_deck_status : bool = false

signal buy_pressed(CardBulletUI)
signal sell_pressed(CardBulletUI)
signal add_pressed(CardBulletUI)
signal remove_pressed(CardBulletUI)

func _ready() -> void:
	if current_view_type == TYPE.EDIT :
		change_to_edit_view()
	elif current_view_type == TYPE.STORE :
		change_to_store_view()
	else : 
		hide_all_buttons()

func initialize(configuration : CardConfiguration, status : bool = false) :
	# assign all variable needed
	card_configuration = configuration
	card_name.text = card_configuration.card_name
	card_description.text = card_configuration.description
	card_price.text = str(card_configuration.card_price)
	
	card_deck_status = status
	card_status_label.text = "NOT USED" if card_deck_status == false else "ACTIVE"
	check_edit_button_availability()
	
	#initialize card object ui
	card_object_ui.initialize(card_configuration)

#region buttons

func _on_add_button_pressed() -> void:
	add_pressed.emit(self)

func _on_remove_button_pressed() -> void:
	sell_pressed.emit(self)

func _on_buy_button_pressed() -> void:
	buy_pressed.emit(self)

func _on_sell_button_pressed() -> void:
	sell_pressed.emit(self)

#endregion

#region type views

func hide_all_buttons():
	for button in button_options.get_children() : 
		if button is Control : button.hide()

func change_to_edit_view():
	hide_all_buttons()
	current_view_type = TYPE.EDIT
	
	card_status_label.show()
	add_button.show()
	remove_button.show()

func change_to_store_view():
	hide_all_buttons()
	current_view_type = TYPE.STORE
	
	card_status_label.hide()
	buy_button.show()
	sell_button.show()

#endregion

#region edit view
func check_edit_button_availability() :
	# check button
	remove_button.disabled = !card_deck_status
	add_button.disabled = card_deck_status
#endregion
