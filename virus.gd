extends CharacterBody2D


const SPEED = 300.0

var spt:Texture2D
func _ready() -> void:
	spt = $Sprite2D.texture

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right","up","down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
	Manager.emit_signal("player_position_updated",global_position,SPEED)
	print("")
	if Input.is_action_just_pressed("space"):
		print("camuflou")
		
	move_and_slide()

func steal_icon(a):
	$Sprite2D.texture = a
	$Sprite2D.hframes = 1
	$Sprite2D.vframes = 1
	$AnimationPlayer.stop()
	$Area2D/CollisionShape2D.disabled = true
	print(a)
func on_area_entered(area: Area2D) -> void:
	if area.is_in_group("folder"):
		steal_icon(area.get_node("Sprite2D").texture)

func on_area_exited(area: Area2D) -> void:
	await get_tree().create_timer(2.0).timeout
	$Sprite2D.hframes = 3
	$AnimationPlayer.play("idle")
	$Area2D/CollisionShape2D.disabled = false
	$Sprite2D.texture = spt
	
