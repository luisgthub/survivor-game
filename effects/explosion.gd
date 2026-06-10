extends CPUParticles2D

func _ready() -> void:
	# Ativa as partículas assim que nascer na cena
	emitting = true
	# Espera o tempo de vida acabar e deleta a explosão da memória
	await get_tree().create_timer(lifetime).timeout
	queue_free()
