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

	hide_textbox()
	queue_text("Wizard: Well, we meet again brave adventurer! <press E to continue...>")
	queue_text("Wizard: You are one of the very few that have ever beat this dungeon...")
	queue_text("Wizard: Seems like I must deal with you myself then...")
	queue_text("Wizard: *dry cackle*")
	queue_text("You: What do you mean, Wizard?")
	queue_text("Wizard: You naive young fool. I tricked you into exploring this dungeon.")
	queue_text("You: HOW COULD YOU! What do you even have to gain from this?")
	queue_text("Wizard: For years I have tricked adventurers into this dungeon.")
	queue_text("Wizard: Once they succumbed to my monsters, I gathered their souls.")
	queue_text("Wizard: With these souls, I was able to strengthen and heal myself.")
	queue_text("Wizard: I was able to overcome my old age and frailness by doing this.")
	queue_text("You: Your trickery ends here, Wizard. I'll end you once and for all!")
	queue_text("Wizard: Enough out of you! You don't know what I have gone through!")
	queue_text("Wizard: Prepare to never see the light of day again.")
	queue_text("You: So be it. I will defeat you and help change your ways.")

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
					Game.bossBattle=true

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
	#print("displaying text")
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

	end_symbol.text = "*"
	change_state(State.FINISHED)
