extends CanvasLayer

const CHAR_READ_RATE = 0.05

@onready var textbox_container = $TextboxContainer
@onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label

var tween : Tween = Tween.new()


enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []

func _ready():
	tween.connect("finished", on_tween_finished)
	print("Starting state: State.READY")
	hide_textbox()
	queue_text("Wizard: Welcome young lad, to the world of Mysteria! <press E to continue...>")
	queue_text("Wizard: We were once a prosperous civilization with beautiful land and riches!")
	queue_text("Wizard: But recently a dire threat has been found in our sacred ancient dungeon!")
	queue_text("Wizard: I'm afraid I'm far too old to enter the dungeon however, so you'll have to take them on...")
	queue_text("Wizard: Are you up for the challenge young lad?")
	queue_text("You: Of course!")
	queue_text("Wizard: Continue right past me and you'll come up on the dungeon. Good luck!")

func _process(delta):
	match current_state:
		State.READY:
			if !text_queue.size() == 0:
				display_text()
		State.READING:
			#if Input.is_action_just_pressed("ui_accept"):
			
			#tween ratio here ....
			label.visible_ratio = 1.0
			
			tween.stop()
			end_symbol.text = "v"
			change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("interact") and get_parent().textbox_visible:
				change_state(State.READY)
				hide_textbox()
				if text_queue.size() == 0:
					get_parent().can_move = true
				

func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	textbox_container.hide()

func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()

func display_text():
	print("displaying text")
	var next_text = text_queue.pop_front()
	label.text = next_text
	label.visible_ratio = 0.0
	change_state(State.READING)
	show_textbox()
	tween.interpolate_value(label.visible_ratio, 1, 0, len(next_text) * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	#tween.interpolate_value(label, "percent_visible", 0.0, 1.0, len(next_text) * CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.play()

func change_state(next_state):
	current_state = next_state
#	match current_state:
#		State.READY:
#			print("Changing state to: State.READY")
#		State.READING:
#			print("Changing state to: State.READING")
#		State.FINISHED:
#			print("Changing state to: State.FINISHED")

func on_tween_finished():
	print("poooppopoo")
	end_symbol.text = "*"
	change_state(State.FINISHED)
