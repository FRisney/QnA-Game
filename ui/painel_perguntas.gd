extends CanvasLayer

onready var label_pergunta: = find_node("LaP")
onready var label_alternativa_a: = find_node("LaAltA")
onready var label_alternativa_b: = find_node("LaAltB")
onready var anim_panel: = find_node("_anim")
var data: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
# warning-ignore:return_value_discarded
	Events.connect("changed_destination", self, "_on_changed_destination")
# warning-ignore:return_value_discarded
	anim_panel.connect("animation_finished", self, "_on_finished_animation")


func _on_changed_destination(_data: Dictionary):
	data = _data
	if data.has("first"):
		label_pergunta.text = data.per
		label_alternativa_a.text = data.alt_a
		label_alternativa_b.text = data.alt_b
		anim_panel.play("in")
	else:
		anim_panel.play("out")


func _on_finished_animation(animation_name: String):
	if animation_name == "out":
		match data.type:
			0:
				label_pergunta.text = data.per
				label_alternativa_a.text = data.alt_a
				label_alternativa_b.text = data.alt_b
				anim_panel.play("in")
			1:
				label_pergunta.text = data.decl


func _on_Button_pressed() -> void:
	Events.emit_signal("changed_choice", 0)


func _on_Button2_pressed() -> void:
	Events.emit_signal("changed_choice", 1)
