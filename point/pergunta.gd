extends "res://point/Point.gd"

export(Array, NodePath) var path_alternativas: Array
export(String, MULTILINE) var pergunta := "Pergunta"
export(String, MULTILINE) var alternativaA := "Alternativa A"
export(String, MULTILINE) var alternativaB := "Alternativa B"

func _ready() -> void:
	# Declarar o tipo para pergunta
	type = 0
	# Guardar o caminho para as alternativas
	path_alternativas.append(get_node("A").get_path())
	path_alternativas.append(get_node("B").get_path())
