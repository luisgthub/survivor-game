extends CharacterBody2D
var state = [""]
var destination = Vector2(20,-30)
var player_target : Vector2
var speed = 30
var new_speed:float
var tgt:Vector2
var offset = Vector2(5,5)
func _ready() -> void:
	tgt =destination
	Manager.player_position_updated.connect(_on_player_position_updated)
func _on_player_position_updated(pos:Vector2,spd:float):
	player_target = pos
	new_speed = spd
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dist = global_position.distance_to(tgt)
	if chasing:
		tgt = player_target
	else:
		tgt=destination
	if dist>30:	
		var direction = (tgt-global_position).normalized()	
		velocity = direction*speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()

var chasing = false
func on_area_entered(area: Area2D) -> void:
	if area.is_in_group("virus"):
		$Sprite2D.modulate = Color.BLUE_VIOLET
		print(player_target)
		chasing = true
		speed = new_speed
		global_position = player_target
		
