tool
extends Node2D

func _draw() -> void:
	# Qaundo no editor
	if Engine.editor_hint:
		# Desenha a linha ate o Node pai
#		var trace: Line2D =
		get_node("../_trace").set_point_position(0, get_parent().position * -1)

		if get_parent().type == 0:
			# Desenha um circulo em volta da pergunta determinando a area de tensao
			draw_circle(Vector2.ZERO, 440, Color(0.0, 0.0, 0.0, 0.3))
		else:
			# Desenha um circulo em volta do final
			draw_circle(Vector2.ZERO, 100, Color(1.0, 1.0, 1.0, 0.2))
