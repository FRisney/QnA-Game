extends CanvasLayer

onready var tipo: Label = find_node("TipoFinal")
onready var declaracao: Label = find_node("Declaracao")
var text: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	Events.connect("finished_questions", self, "_on_finished_questions")

func _on_finished_questions(data: Dictionary):
	match data.type:
		1: tipo.text = "Sucesso"
		2: tipo.text = "Fracasso"
		3: tipo.text = "Alerta"
	declaracao.text = data.decl
	$_anim.play("trans")
