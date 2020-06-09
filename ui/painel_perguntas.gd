extends CanvasLayer

onready var label_pergunta: = find_node("LaP")
onready var label_alternativa_a: = find_node("LaAltA")
onready var label_alternativa_b: = find_node("LaAltB")
onready var anim_panel: = find_node("_anim")
var text: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.connect("changed_destination", self, "_on_changed_destination")
	Events.connect("finished_questions", self,"_on_finished_questions")
	anim_panel.connect("animation_finished", self, "_on_finished_animation")


func _on_changed_destination(data: Dictionary):
	text = data
	anim_panel.play("out")


func _on_finished_animation(animation_name: String):
	if animation_name == "out":
		label_pergunta.text = text.per
		if text.has("alt_a") and text.has("alt_b"):
			label_alternativa_a.text = text.alt_a
			label_alternativa_b.text = text.alt_b
		anim_panel.play("in")


func _on_finished_questions(data: Dictionary):
	pass


func _on_Button_pressed() -> void:
	Events.emit_signal("changed_choice", 0)


func _on_Button2_pressed() -> void:
	Events.emit_signal("changed_choice", 1)
