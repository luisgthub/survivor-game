extends Node2D

@onready var enemy = preload("res://base_enemy.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = 2
	timer.autostart=true
	timer.timeout.connect(wave_config)
	add_child(timer)
	wave_config()
func wave_config():
	for i in 3:
		spawn_enemy()
func spawn_enemy():
	var inst = enemy.instantiate()
	get_tree().current_scene.add_child(inst)
	#escolhe spawn aleatoriamente
	var get_spawn = get_tree().get_nodes_in_group("spawn_point")
	var choose_spawn = get_spawn.pick_random()
	#print("s",get_spawn)
	inst.global_position = choose_spawn.global_position
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
