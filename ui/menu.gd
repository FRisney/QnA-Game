extends CanvasLayer

func _on_Sair_pressed():
	get_tree().quit()


func _on_Iniciar_pressed():
	Events.emit_signal("menu_exited")
	$_anim.play("out")


func _on_Creditos_pressed():
	Events.emit_signal("credits_opened")
