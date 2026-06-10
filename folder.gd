extends Area2D
@onready var window = preload("res://window.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_window():
	var inst = window.instantiate()
	inst.global_position = global_position + Vector2(0,100)
	get_tree().current_scene.add_child(inst)
func on_button_pressed() -> void:
	create_window()
