extends EditDeckPanel

@export var currency_label : Label
@export var card_bullet_ui_prefab : PackedScene

@export_category("Store Card List Section")
@export var card_list_box_container : Control

var card_bullet_list : Array[CardBulletUI] = []

func initialize():
	currency_label.text = str(GameManager.player_profile.current_money)
	populate_store_item()
	
	super.initialize()

func populate_store_item():
	# reset all list 
	clear_list(card_bullet_list)
	
	# get latest current deck from player profile
	var current_deck = GameManager.player_profile.current_deck
	
	# get card collection 
	var current_collection = GameManager.player_profile.current_collection
	
	#populate available cards panel
	for card_id in current_collection :
		var card_bullet : CardBulletUI = card_bullet_ui_prefab.instantiate()
		var card_status : bool = true if current_collection[card_id] == CardId.CardAvailabilityId.OWNED else false
		card_bullet.initialize(GameManager.get_card_configuration(card_id),card_status)
		card_bullet.change_to_store_view()
		
		card_bullet.buy_pressed.connect(on_buy_card_pressed)
		card_bullet.sell_pressed.connect(on_sell_card_pressed)
		
		card_list_box_container.call_deferred("add_child", card_bullet)
		card_bullet_list.append(card_bullet)

func clear_list(list : Array) :
	for item in list : 
		if item is Control :
			item.queue_free()
	
	list.clear()

func on_buy_card_pressed(selected_card : CardBulletUI):
	if GameManager.player_profile.current_money < selected_card.card_configuration.card_price : 
		var notification : BaseNotification = NotificationManager.spawn_base_notification()
		notification.initialize("Not Enough Currency")
		return
	
	GameManager.player_profile.buy_card_to_collection(selected_card.card_configuration.get_id() , selected_card.card_configuration.card_price)
	populate_store_item()
	
	currency_label.text = str(GameManager.player_profile.current_money)

func on_sell_card_pressed(selected_card : CardBulletUI):
	GameManager.player_profile.sell_card_from_collection(selected_card.card_configuration.get_id() , selected_card.card_configuration.card_price)
	populate_store_item()
	
	currency_label.text = str(GameManager.player_profile.current_money)
