extends Button

@export var audio_stream_player : AudioStreamPlayer

func _enter_tree() -> void:
	set_center_pivot()

func _on_pressed() -> void:
	audio_stream_player.play()

func set_center_pivot():
	self.pivot_offset = Vector2(size.x * scale.x / 2.0 , size.y * scale.y / 2.0)
