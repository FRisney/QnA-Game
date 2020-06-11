extends Sprite

#var remote_car_scene: PackedScene = preload("res://car/RemoteCar.tscn")
onready var remote_car: RemoteTransform2D = get_owner().find_node("RemoteCar")
onready var trk: Line2D = get_owner().find_node("Track")
onready var parent: Sprite = get_owner().find_node("P")
onready var dest: Sprite = get_owner().find_node("P")
var data: Dictionary
var prevpos: Vector2
var newpos: Vector2
var newrot: = 0.0
var move_speed: = 50.0
var rot_speed: = 0.2
var alt_sel: = 0
var trk_point: = 0
var _first: bool


func _ready() -> void:
# warning-ignore:return_value_discarded
		Events.connect("changed_choice",self, "_on_changed_choice")
		trk_point = trk.points.size()
#		remote_car = remote_car_scene.instance()
#		remote_car.global_position = parent.global_position * -1
#		parent.add_child(remote_car)
		remote_car.rotation = parent.global_position.angle_to_point(remote_car.global_position)
		remote_car.set_remote_node(get_path())
		parent.get_node("_anim").play("in")
		_first = true
		data = {"first": true, "per": parent.pergunta,	"alt_a": parent.alternativaA,	"alt_b": parent.alternativaB, "type": dest.type}
		


func _physics_process(_delta: float) -> void:
	if parent.name == "P" and _first:
		_first = false
		parent.get_node("_anim").play("in")
		Events.emit_signal("changed_destination", data)
	var dist = floor(remote_car.get_position().distance_to(Vector2.ZERO))
	if (dist as int) % 5 == 0:
		if dist == 100:
			parent.find_node("_anim", false).play("out")
		elif dist == 440 and parent.type == 0:
			Events.emit_signal("started_tension")
			$_anim.play("bump")
	if dist > 1:
		newpos = remote_car.get_position().move_toward(Vector2.ZERO, get_physics_process_delta_time() * move_speed)
		newrot = parent.global_position.angle_to_point(remote_car.global_position)
		var rot = lerp_angle(remote_car.rotation, newrot, rot_speed)
		remote_car.rotation = rot
		remote_car.set_position(newpos)
		trk.set_point_position(trk_point-1, global_position)
	else:
		prevpos = remote_car.get_global_position()
		parent = remote_car.get_parent()
		if parent.type != 0:
			data = {"decl": parent.declaracao}
			Events.emit_signal("finished_questions", data)
		else:
			dest = parent.get_node_or_null(parent.path_alternativas[alt_sel])
			trk_point+=1
			trk.add_point(prevpos)
			parent.remove_child(remote_car)
			dest.add_child(remote_car)
			remote_car.set_remote_node(get_path())
			remote_car.set_global_position(prevpos)
			parent = dest
			dest.get_node("_anim").play("in")
			data = {"type": 1, "decl": dest.declaracao} if dest.type != 0 else {"type": 0, "per": dest.pergunta, "alt_a": dest.alternativaA, "alt_b": dest.alternativaB}
			Events.emit_signal("changed_destination", data)


func _on_changed_choice(choice:int):
	alt_sel = choice

#func move_car():
#	newpos = remote_car.get_position().move_toward(Vector2.ZERO, get_physics_process_delta_time() * move_speed)
#	newrot = parent.global_position.angle_to_point(remote_car.global_position)
#	var rot = lerp_angle(remote_car.rotation, newrot, rot_speed)
#	remote_car.rotation = rot
#	remote_car.set_position(newpos)
#	trk.set_point_position(trk_point-1, remote_car.global_position)


#func change_destination():
#	var data
#	prevpos = remote_car.get_global_position()
#	parent = remote_car.get_parent()
#	if parent.final:
#		data = {"per": parent.pergunta}
#		Events.emit_signal("finished_questions", data)
#	else:
#		var dest = parent.get_node_or_null(parent.path_alternativas[alt_sel])
#		trk_point+=1
#		trk.add_point(prevpos)
#		parent.remove_child(remote_car)
#		dest.add_child(remote_car)
#		remote_car.set_remote_node($Car.get_path())
#		remote_car.set_global_position(prevpos)
#		parent = dest
#		parent.get_node("AnimationPlayer").play("in")
#		data = {"per": dest.pergunta} if dest.final else {"per": dest.pergunta, "alt_a": dest.alternativaA, "alt_b": dest.alternativaB}
#		Events.emit_signal("changed_destination", data)
