extends Node2D


@export var text_display: String
@onready var tbox = $TextboxContainer/MarginContainer/HBoxContainer/Label
var is_visible = false



func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		print("texbox displayed")
		self.visible = true
		tbox.text = text_display
	pass # Replace with function body.
