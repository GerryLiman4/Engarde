extends GeneralPopupMenu

# for alignment purposes
@export var spacer : Control

@export_category("Tabs Panel")
@export var my_deck_panel : EditDeckPanel 
@export var shop_panel : EditDeckPanel 

var current_panel : EditDeckPanel

func initialize():
	super.initialize()

func open_popup():
	spacer.show()
	super.open_popup()

func hide_popup():
	current_panel.hide()
	spacer.show()
	super.hide_popup()

func _on_edit_button_pressed() -> void:
	switch_panel(my_deck_panel)

func _on_shop_button_pressed() -> void:
	switch_panel(shop_panel)

func switch_panel(designated_panel : EditDeckPanel):
	if current_panel != null : current_panel.hide()
	current_panel = designated_panel
	
	current_panel.initialize()
	spacer.hide()
