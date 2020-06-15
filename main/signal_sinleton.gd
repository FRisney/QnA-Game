extends Node

# Sinais que poderao ser usados a partir de qualquer Node a qualquer momento
# warning-ignore:unused_signal
signal changed_destination(data)
# warning-ignore:unused_signal
signal finished_questions(data)
# warning-ignore:unused_signal
signal changed_choice(choice)
# warning-ignore:unused_signal
signal started_tension
# warning-ignore:unused_signal
signal menu_exited
# warning-ignore:unused_signal
signal credits_opened
# warning-ignore:unused_signal
signal map_restarted
# warning-ignore:unused_signal
signal cam_uncentered


func _ready() -> void:
# warning-ignore:return_value_discarded
	Events.connect("started_tension", self, "_on_started_tension")
# warning-ignore:return_value_discarded
	Events.connect("changed_destination", self, "_on_changed_destination")
# warning-ignore:return_value_discarded
	Events.connect("changed_choice", self, "_on_changed_choice")
# warning-ignore:return_value_discarded
	Events.connect("cam_uncentered", self, "_on_cam_uncentered")


func _on_started_tension():
	Audio.get_node("Tensao").play()


func _on_changed_destination(data: Dictionary):
	if not data.has("first"): Audio.get_node("Resposta").play()


func _on_changed_choice(_choice: int):
	Audio.get_node("Alternativa").play()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("alt_a"):
		Events.emit_signal("changed_choice", 0)
	if event.is_action_pressed("alt_b"):
		Events.emit_signal("changed_choice", 1)


func _on_cam_uncentered():
	get_node("/root/MAIN/Car/_anim").play("center")
#	get_tree().get_root().find_node("Car").get_node("_anim").play("center")
