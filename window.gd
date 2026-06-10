extends TileMapLayer
@onready var folder = preload("res://folder.tscn")
func _ready() -> void:
	pass
func on_close_pressed() -> void:
	queue_free()
