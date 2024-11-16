extends Node

@export var fader_animator : AnimationPlayer

const scene_list : Dictionary = {
	"MainMenu" : "res://Scene/MainMenu.tscn",
	"EditDeck" : "res://Scene/EditDeckMenu.tscn",
	"Campaign" : "",
}

func load_scene_by_id(scene_id:String):
	if !scene_list.has(scene_id): return
	
	fader_animator.play("FadeOut")
	await get_tree().create_timer(0.5).timeout
	
	get_tree().change_scene_to_file(scene_list[scene_id])
	
	fader_animator.play("FadeIn")

func load_scene_by_path(scene_path :String):
	if !scene_list.values().has(scene_path) : return
	
	fader_animator.play("FadeOut")
	await get_tree().create_timer(0.5).timeout
	
	get_tree().change_scene_to_file(scene_path)
	
	fader_animator.play("FadeIn")
