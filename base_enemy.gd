extends CharacterBody2D
class_name BaseEnemy
enum  state {DEFENDING,INFECTED,EXPLODE,HEALING}
@onready var explode = preload("res://effects/explosion.tscn")
var current_state = state.DEFENDING
var destination = Vector2(20,-30)
var player_target : Vector2
var speed = 30
var new_speed:float
var tgt:Vector2
var life = 3 
var offset = Vector2(5,5)
func _ready() -> void:
	tgt =destination
	Manager.player_position_updated.connect(_on_player_position_updated)
func _on_player_position_updated(pos:Vector2,spd:float):
	player_target = pos
	new_speed = spd
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	match current_state:		
		state.DEFENDING:
			var direction = (tgt-global_position).normalized()	
			velocity = direction*speed
		state.INFECTED:
			infected_status()
		state.EXPLODE:
			explode_status()
	move_and_slide()

func infected_status():
	velocity = Vector2.ZERO
	print("teste")
	current_state = state.EXPLODE
func explode_status():
	if life<=0:
		var inst = explode.instantiate()	
		inst.global_position = position
		get_tree().current_scene.add_child(inst)
		queue_free()
func find_next_enemy():
	var enemy_list = get_tree().get_nodes_in_group("enemy")
func take_damage(value):
	life-=value
	$lifebar.value = life
func on_area_entered(area: Area2D) -> void:
	if area.is_in_group("virus"):
		$Sprite2D.modulate = Color.BLUE_VIOLET
		take_damage(1)
		#remove_from_group("enemy")
		#add_to_group("ally")
		current_state = state.INFECTED
		#speed = new_speed
		#global_position = player_target
	if area.is_in_group("area"):
		queue_free()
