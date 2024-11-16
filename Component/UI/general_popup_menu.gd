extends Control

class_name GeneralPopupMenu

@export var audio_stream_player : AudioStreamPlayer

func open_popup():
	audio_stream_player.play()
	self.show()

func hide_popup():
	self.hide()

func initialize():
	pass
