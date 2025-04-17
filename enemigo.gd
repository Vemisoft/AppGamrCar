extends CharacterBody2D
@export var velocidad := 300

func _ready() -> void:
	randomize()

func _physics_process(delta):
	#position.y += velocidad * delta
	#velocity = Vector2.DOWN * velocidad
	#move_and_slide()
	#**********************************************
	var colision = move_and_collide(Vector2(0, velocidad * delta))
	if colision and colision.get_collider().is_in_group("Jugador"):
		colision.get_collider().recibir_golpe()
		queue_free()
	#**********************************************

	var alto_pantalla = get_viewport_rect().size.y
	var altura_enemigo = $EnemigoChild.texture.get_size().y
	
	if position.y > (alto_pantalla - (alto_pantalla/30)):
		queue_free()
