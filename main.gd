extends Node2D
@onready var Enemigo = preload("res://enemigo.tscn")
@onready var Score = preload("res://Score.tscn")

@onready var timer = $TimerEnemigo
@onready var timerScore = $TimerScore

func _ready():
	$ColorRect.z_index = 0
	$Jugador.z_index = 2
	timer.timeout.connect(_on_TimerEnemigo_timeout)
	timerScore.timeout.connect(_on_TimerScore_timeout)


func _on_TimerScore_timeout():
	#*****************************************
	var Nuevo_Score = Score.instantiate()
	var pantalla = get_viewport().size
	Nuevo_Score.position = Vector2(0, -50)
	add_child(Nuevo_Score)
	#*****************************************

func _on_TimerEnemigo_timeout():
	#*****************************************
	var nuevo_Enemigo = Enemigo.instantiate()
	var sprite_node = nuevo_Enemigo.get_node("Enemigo.EnemigoChild")
	#Va manual debido a que recupera valores exagerados
	var sprite_Alt = 50
	var sprite_Anch = 70
	#sprite_node.texture.get_size().y
	
	#*****************************************
	var ancho_pantalla = get_viewport_rect().size.x
	var alto_inicial = -32  # Un poco fuera de pantalla por arriba
	#*****************************************
	var Banner_Der = get_node("VidasLabel").get_size().x	 #Ancho del Banner Derecho
	var Banner_Izq = get_node("VidasLabel").get_size().x	 #Ancho del Banner Izquierdo
	ancho_pantalla = ancho_pantalla - Banner_Der
	ancho_pantalla = ancho_pantalla - Banner_Izq
	ancho_pantalla = ancho_pantalla - sprite_Anch
	#*****************************************
	
	var posicion_x = randf_range(Banner_Der, ancho_pantalla)
	nuevo_Enemigo.position = Vector2(posicion_x, alto_inicial)
	
	add_child(nuevo_Enemigo)
