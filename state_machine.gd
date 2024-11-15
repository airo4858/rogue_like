extends Node

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name] = child
			child.change_state(on_state_change)
	if initial_state:
		initial_state.on_enter_state()
		current_state = initial_state

func _process(delta: float):
	if current_state:
		current_state.process_state(delta)
		
func _physics_process(delta: float):
	if current_state:
		current_state.physics_process_state(delta)

func on_state_change(state, new_state_name):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name) 
	if !new_state:
		return
	
	if current_state:
		current_state.on_exit_state()
	
	new_state.on_enter_state()
	current_state = new_state
