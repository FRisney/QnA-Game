extends Node

onready var map_scn = preload("res://maps/Mapa.tscn")
var map
onready var car_scn = preload("res://car/Car.tscn")
var car
onready var per_scn = preload("res://ui/PainelPerguntas.tscn")
var per
onready var fim_scn = preload("res://ui/Final.tscn")
var fim
onready var menu_scn = preload("res://ui/Menu.tscn")
var menu
onready var crdt_scn = preload("res://ui/Creditos.tscn")
var crdt

func _ready() -> void:
# warning-ignore:return_value_discarded
#	Events.connect("finished_questions", self, "_on_finished_questions")
# warning-ignore:return_value_discarded
	Events.connect("menu_exited", self, "_on_map_started")
# warning-ignore:return_value_discarded
	Events.connect("map_restarted", self, "_on_map_started")
# warning-ignore:return_value_discarded
	Events.connect("credits_opened", self, "_on_creditos_opened")
	start_ui()
	menu.get_node("_anim").connect("animation_finished", self, "_on_menu_animation_finished")
	fim.get_node("_anim").connect("animation_finished", self, "_on_finished_questions")
	


func start_ui():
	menu = menu_scn.instance()
	fim = fim_scn.instance()
	per = per_scn.instance()
	crdt = crdt_scn.instance()
	add_child(menu)
	add_child(fim)
	add_child(per)
	add_child(crdt)


func _on_map_started():
	map = map_scn.instance()
	add_child(map)
	car = car_scn.instance()
	add_child(car)


func _on_finished_questions(anim_name):
	if anim_name == "trans":
		car.free()
		map.free()
		per.get_node("_anim").play_backwards("end")

func _on_menu_animation_finished(anim_name):
	if anim_name == "out":
		menu.queue_free()


func _on_creditos_opened():
	crdt.get_node("_anim").play("in")
