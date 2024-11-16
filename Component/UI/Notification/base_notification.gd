extends CanvasLayer

class_name BaseNotification

@export var notification_label : Label

func initialize(note : String):
	notification_label.text = note

func _on_confirm_button_pressed() -> void:
	SignalManager.notification_confirm.emit()
	queue_free()
