extends Node

@export var base_notification_prefab : PackedScene

func spawn_base_notification() :
	var notif = base_notification_prefab.instantiate()
	
	get_tree().root.call_deferred("add_child",notif)
	
	return notif
