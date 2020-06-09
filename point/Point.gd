extends Sprite

export(int, "Pergunta", "Sucesso", "Fracasso", "Alerta") var type: int

func _init() -> void:
	if not Engine.editor_hint:	# Quando estiver in-game
		$_editor.free()			# Tirar o Node _editor da Scene Tree

func _ready() -> void:
	# Se o scripts nao estiver rodando no editor, nao inicia a animacao
	$_trace.set_point_position(0, position * -1)

	# Desenha a linha ate o Node pai
	# O Node pai testa na coordenada (0,0)
	# Entao desenha de (0,0) ate este Node
	if not Engine.editor_hint: $_anim.play("out")
