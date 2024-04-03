extends Node2D




func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		#change scene
		if Game.bossBattle==true:
			get_tree().change_scene_to_file("res://end_screen.tscn")
		else:
			get_tree().change_scene_to_file("res://boss.tscn")
			Game.bossBattle=true
	pass # Replace with function body.
	
func _process(delta):
	if Game.bossBattle==true:
		$".".position.x=5000
		if Game.bossHP<=1:
			$".".position.x=649
			
