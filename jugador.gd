extends CharacterBody2D

@export var velocidad := 200
var ContVidas = 3
var ContResetGame = 5
#********************************
var jugando = true
@onready var pausa_timer : Timer = get_parent().get_node("PausaTimer") #$PausaTimer
@onready var reinicio_timer : Timer = get_parent().get_node("ReinicioTimer") #$ReinicioTimer
@onready var resetGame_timer : Timer = get_parent().get_node("ResetGame") #ResetGame
@onready var vidas_label : Label = get_parent().get_node("VidasLabel") #$VidasLabel
@onready var game_over_label : Label = get_parent().get_node("GameOverLabel") #$GameOverLabel  # Asegúrate de tener este Label en la escena, invisible al inicio
@onready var cuenta_regresiva_label : Label = get_parent().get_node("CuentaRegresivaLabel")
#********************************	
func _ready():
	vidas_label.text = "💥 Vidas: %d" % ContVidas
	game_over_label.visible = false
	cuenta_regresiva_label.visible = false
	pausa_timer.timeout.connect(_on_PausaTimer_timeout)
	reinicio_timer.timeout.connect(_on_ReinicioTimer_timeout)
	resetGame_timer.timeout.connect(_on_resetGame_timeout)

	
func _physics_process(delta):
	if not jugando:
		return
	var direccion = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direccion.x += 1
	if Input.is_action_pressed("ui_left"):
		direccion.x -= 1
	if Input.is_action_pressed("ui_down"):
		direccion.y += 1
	if Input.is_action_pressed("ui_up"):
		direccion.y -= 1
	#************************
	velocity = direccion.normalized() * velocidad
	move_and_slide()
	#************************
	var pos = global_position
	pos.x = clamp(pos.x, 195, (1152 - 230))
	pos.y = clamp(pos.y, 60, 590)

	global_position = pos

func perder_vida():
	if jugando:
		ContVidas -= 1
		vidas_label.text = "Vidas: %d" % ContVidas
		jugando = false  # Pausa lógica
		pausa_timer.start()  # Espera 2 segundos

		if ContVidas <= 0:
			game_over()
			
func recibir_golpe():
	if jugando:
		ContVidas -= 1
		vidas_label.text = "💥 Vidas: %d" % ContVidas
		jugando = false  # Con esto activo ld Pausa
		
		if ContVidas <= 0:
			game_over()
		else:
			get_tree().paused = true #Con esto pausamos todo los Obj
			jugando = false
			pausa_timer.start()  # Llamamos a la puase de 2 segundos

func _on_PausaTimer_timeout():
	if ContVidas > 0:
		get_tree().paused = false  #Quitamos la puasa y activos el juego de nuevo.
		jugando = true

func game_over():
	jugando = false
	game_over_label.visible = true
	game_over_label.text = "💀 GAME OVER 💀"
	#********************
	get_tree().paused = true
		#*******************************
	ContResetGame = 5
	cuenta_regresiva_label.visible = true
	cuenta_regresiva_label.add_theme_color_override("font_color", Color.RED)
	cuenta_regresiva_label.add_theme_font_size_override("font_size", 36)
	cuenta_regresiva_label.text = "%02d" % ContResetGame
	resetGame_timer.start()
	#*******************************
func _on_resetGame_timeout ():
	ContResetGame -= 1
	if ContResetGame > 0:
		cuenta_regresiva_label.text = "%02d" % ContResetGame
	elif ContResetGame == 0:
		cuenta_regresiva_label.text = "Ready!"
		reinicio_timer.start()
	else:
		reinicio_timer.stop()
		
func _on_ReinicioTimer_timeout():
	get_tree().paused = false	
	get_tree().reload_current_scene()
	
# - Categoría	Viñetas
# - 🎨 Creatividad y diseño	🎨 🖌️ 🧵 🧶 🧷 🖼️ 🧺 🎭
# - 💻 Desarrollo y tecnología	🧮 🖥️ 🧑‍💻 🧾 📂 🧰 🛡️ 💾
# - 📚 Educación y organización	📚 🗂️ 📖 🧑‍🏫 📝 📅 📌 🧷
# - 🔄 Proceso y flujo	🔄 🔂 ⏩ ⏳ ⌛ 🧭 📊 🗃️
# - 🚧 Advertencia y control	🚫 ⚠️ 🚧 ⛔ 📛 🔒 🔐 🧯
# - 🌟 Éxito y progreso	🏆 🥇 🎖️ 🌈 🚦 🌟 🎊 🎉
# - 🧪 Ciencia y pruebas	🧫 🧬 🔬 🧪 🧻 🧯 🧹 🧼
# - 🎮 Juegos y entretenimiento	🕹️ 👾 🧩 🎲 🃏 🎯 🎰 💡 ☠️
