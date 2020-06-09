tool
extends Node2D

func _draw() -> void:
	# Qaundo no editor
	if Engine.editor_hint:
		# Desenha a linha ate o Node pai
		get_node("../_trace").set_point_position(0, get_parent().position * -1)
		# Desenha um circulo determinando a area de tensao
		draw_circle(Vector2.ZERO, 440, Color(0.0, 0.0, 0.0, 0.3))
