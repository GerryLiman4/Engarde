extends EditDeckPanel

@export var card_object_ui_prefab : PackedScene
@export var card_bullet_ui_prefab : PackedScene

@export_category("Deck Section")
@export var deck_box_container : Control
var card_object_list : Array[CardObjectUI] = []

@export_category("Available Cards Section")
@export var available_cards_box_container : Control
var card_bullet_list : Array[CardBulletUI] = []

func initialize():
	populate_deck_card_ui_list()
	populate_available_card_ui_list()
	
	super.initialize()

func clear_list(list : Array) :
	for item in list : 
		if item is Control :
			item.queue_free()
	
	list.clear()

func populate_deck_card_ui_list():
	# reset all list 
	clear_list(card_object_list)
	
	# get latest current deck from player profile
	var current_deck = GameManager.player_profile.current_deck
	
	# populate card object list
	for card_id in current_deck :
		var card_object : CardObjectUI = card_object_ui_prefab.instantiate()
		card_object.initialize(GameManager.get_card_configuration(card_id))
		
		card_object.selected.connect(on_deck_card_selected)
		
		deck_box_container.call_deferred("add_child", card_object)
		card_object_list.append(card_object)

func populate_available_card_ui_list():
	# reset all list 
	clear_list(card_bullet_list)
	
	# get latest current deck from player profile
	var current_deck = GameManager.player_profile.current_deck
	
	# get card collection 
	var current_collection = GameManager.player_profile.current_collection
	
	#populate available cards panel
	for card_id in current_collection :
		if current_collection[card_id] == CardId.CardAvailabilityId.NOT_OWNED : continue
		
		var card_bullet : CardBulletUI = card_bullet_ui_prefab.instantiate()
		var card_status : bool = true if current_deck.has(card_id) else false
		card_bullet.initialize(GameManager.get_card_configuration(card_id),card_status)
		card_bullet.change_to_edit_view()
		
		card_bullet.add_pressed.connect(on_add_card_pressed)
		card_bullet.remove_pressed.connect(on_remove_card_pressed)
		
		available_cards_box_container.call_deferred("add_child", card_bullet)
		card_bullet_list.append(card_bullet)

func on_deck_card_selected(selected_card_object : CardObjectUI) :
	GameManager.player_profile.remove_card_from_deck(selected_card_object.card_configuration.get_id())
	populate_deck_card_ui_list()
	populate_available_card_ui_list()

func on_add_card_pressed(selected_card_bullet : CardBulletUI) :
	GameManager.player_profile.add_card_to_deck(selected_card_bullet.card_configuration.get_id())
	populate_deck_card_ui_list()
	populate_available_card_ui_list()

func on_remove_card_pressed(selected_card_bullet : CardBulletUI) :
	GameManager.player_profile.remove_card_from_deck(selected_card_bullet.card_configuration.get_id())
	populate_deck_card_ui_list()
	populate_available_card_ui_list()
