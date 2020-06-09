extends Sprite

export(int, "Pergunta", "Sucesso", "Fracasso", "Alerta") var type: int

func _ready() -> void:
	if not Engine.editor_hint:	# Quando estiver in-game
		$_editor.free()
	$_trace.set_point_position(0, position * -1)
