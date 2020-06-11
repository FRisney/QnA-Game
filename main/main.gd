extends Node



func _ready() -> void:
# warning-ignore:return_value_discarded
	Events.connect("finished_questions", self, "_on_finished_questions")

func _on_finished_questions():
	pass
