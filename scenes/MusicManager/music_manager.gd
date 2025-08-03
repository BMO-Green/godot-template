@tool
extends Node

''' TODO LIST
* Note Object Pool : manages note instancing
'''


#region Constants
## ====== DATABASE =====
var music_data = MusicData.new()
var music_bank = MusicBank.new()

## AudioServer Bus
enum AUDIO_BUS {
	MASTER,
	MUSIC,
	UI,
	AMBIENCE,
	SFX,
	NOTES
}
#endregion

#region Signals
signal trigger_note() # triggers a note to play
signal toggle_spin_sound() # toggles the spinning root note sound 
signal toggle_chord_sound() # toggles the spinning chord note sound
signal set_spin_sound(active : bool) # set the spin sound on or off
signal set_chord_sound(active : bool) # set the chord sound on or off
signal set_music_key(new_key : MusicData.KEYS)
signal set_music_mode(new_mode : MusicData.MODES)

func _connect_signals() -> void:
	trigger_note.connect(play_note)
	toggle_spin_sound.connect(toggle_root_player)
	toggle_chord_sound.connect(toggle_chord_player)
	set_spin_sound.connect(func (enabled) : root_player_playing = enabled)
	set_chord_sound.connect(func (enabled) : chord_player_playing = enabled)
	set_music_key.connect(func (new_key) : music_key = new_key)
	set_music_mode.connect(func (new_mode) : music_mode = new_mode)
#endregion

#region Toolscript Actions
@export_category("Toolscript Actions")
@export_tool_button("Toggle Root Note") var toggle_root_note_action = toggle_root_player
@export_tool_button("Toggle Chord Note") var toggle_chord_note_action = toggle_chord_player
@export_tool_button("Play Random Note") var play_note_action = play_note
@export_tool_button("Randomize Key") var randomize_key_action = randomize_key
@export_tool_button("Randomize Mode") var randomize_mode_action = randomize_mode
#endregion

#region Music Settings
@export_category("Music Settings")
@export var music_key : MusicData.KEYS = MusicData.KEYS.C:
	set(new_key):
		# LOGGING
		last_key_string = music_data.get_key_string(music_key)
		current_key_string = music_data.get_key_string(new_key)
		print("Current Key: ", current_key_string, "\t- Last Key: ", last_key_string)
		
		# UPDATING
		current_key_scale = music_data.get_key_scale(new_key) # set key scale
		music_key = new_key # update to new KEY enum value
		update_audio_players() # call for audio update
		
@export var music_mode : MusicData.MODES = MusicData.MODES.IONIAN:
	set(new_mode):
		# LOGGING
		last_mode_string = music_data.get_mode_string(music_mode)
		current_mode_string = music_data.get_mode_string(new_mode)
		print("Current Mode: ", current_mode_string, "\t- Last Mode: ", last_mode_string)
		
		# UPDATING
		music_mode = new_mode # update to new KEY enum value
		current_mode_intervals = music_data.get_mode_intervals(new_mode)
		update_audio_players() # call for audio update

@export var scale_variant : MusicData.SCALE_VARIANT = MusicData.SCALE_VARIANT.DIATONIC:
	set(new_scale):
		# UPDATING
		current_mode_intervals = music_data.get_mode_scale_variant_intervals(music_mode, new_scale)
		scale_variant = new_scale

@export var octaves_enabled : Dictionary[float, bool] = { # Octave range for getting notes
	0.25: true, # octave subs
	0.5 : true, # octave lows
	1.0 : true, # octave mids
	2.0 : true, # octave highs
}

## ===== Music Paramters =====
var current_key_scale = music_data.get_key_scale(music_key)
var current_mode_intervals = music_data.get_mode_intervals(music_mode)

var current_key_string : String = music_data.get_key_string(music_key)
var current_mode_string : String = music_data.get_mode_string(music_mode)

var last_key_string : String 
var last_mode_string : String
#endregion

#region Audio Players
@export_category("Audio Players")
@export var note_player : AudioStreamPlayer
@export var root_player : AudioStreamPlayer # Constant root note hum
@export var chord_player : AudioStreamPlayer # Constant chord note hum
@export var notes_panner_effect : AudioEffectPanner

@export var root_player_playing : bool = false: # Set to enable root player
	set(enabled):
		set_root_player(enabled)
		root_player_playing = enabled
@export var chord_player_playing : bool = false: # Set to enable chord player
	set(enabled):
		set_chord_player(enabled)
		chord_player_playing = enabled

# Plays a random note from note_player instance
func play_note():
	print("PLAY NOTE")
	play_random_note_from(note_player)
	return

# Toggles root player on/off
func toggle_root_player():
	set_root_player(!root_player.playing)
	
# Toggles root player on/off
func toggle_chord_player():
	set_chord_player(!chord_player.playing)
	
# Sets root player active to 'on'
func set_root_player(on : bool):
	root_player.play() if on else root_player.stop()
	
# Sets third player active to 'on'
func set_chord_player(on : bool):
	chord_player.play() if on else chord_player.stop()
	
# Sets music_key to random KEYS enum from music_data
func randomize_key() -> void:
	music_key = music_data.get_random_key()

# Sets music_mode to random MODES enum from music_data
func randomize_mode() -> void:
	music_mode = music_data.get_random_mode()
	
# Plays random note from given AudioStreamPlayer node
func play_random_note_from(_audioStreamPlayer : AudioStreamPlayer):
	notes_panner_effect = AudioServer.get_bus_effect(AUDIO_BUS.NOTES, 0)
	notes_panner_effect.pan = randf_range(-1.0, 1.0) # randomize panning
	_audioStreamPlayer.pitch_scale = get_random_note_pitch() # randomize pitch
	_audioStreamPlayer.play() # play that thang!

# Returns a random note pitch within the current key, mode and available octaves
func get_random_note_pitch() -> float:
	var key_pitch = current_key_scale # key center pitch value
	var interval_pitch = current_mode_intervals.pick_random()
	var random_octave = octaves_enabled.keys()[randi() % octaves_enabled.size()]
	
	while (!octaves_enabled[random_octave]):
		random_octave = octaves_enabled.keys()[randi() % octaves_enabled.size()]
		
	var octave_pitch = random_octave
	
	return key_pitch * interval_pitch * octave_pitch

# Updates audio players to current key scale
func update_audio_players():
	pitch_shift_chord(current_key_scale, 1)

# Shifts current notes to updated key scale
func pitch_shift_chord(to_key_interval : float, tween_duration : float = 1):
	var tween: Tween = create_tween().set_parallel()
	tween.tween_property(root_player, "pitch_scale", to_key_interval, tween_duration)
	tween.tween_property(chord_player, "pitch_scale", to_key_interval * current_mode_intervals[2] * 2, 1)
	#tween.tween_property(fifthPlayer, "pitch_scale", to_key_interval * current_mode[4] * 2, 1)
#endregion

#region Initialization
func _ready():
	if !is_instance_valid(root_player):
		printerr("Root player not set - cannot play root note")
	
	debug_layer.visible = !Engine.is_editor_hint()
		
	notes_panner_effect = AudioServer.get_bus_effect(AUDIO_BUS.NOTES, 0)
	
	_connect_signals()
	_connect_ui_methods()
#endregion

#region Chord Progressions
## TODO: implement chord progressions
func generate_chord():
	print("current key: ", current_key_string, " ", current_mode_string)
	if music_bank.chord_progressions.has(current_key_string):
		if music_bank.chord_progressions[current_key_string].has(current_mode_string):
			var new_key_options = music_bank.chord_progressions[current_key_string][current_mode_string]
			var new_option = new_key_options.pick_random()
			#change_key_to(new_option["key"])
			#change_mode_to(new_option["mode"])
		else:
			print("mode not logged yet")
	else:
		print("key not logged yet")
#endregion

#region UI
@export_category("UI Nodes")
@export var debug_layer : CanvasLayer
@export var toggle_root_button : Button
@export var toggle_chord_button : Button
@export var play_note_button : Button
@export var randomize_key_button : Button
@export var randomize_mode_button : Button

func _connect_ui_methods() -> void:
	toggle_root_button.pressed.connect(toggle_root_note_action)
	toggle_chord_button.pressed.connect(toggle_chord_note_action)
	play_note_button.pressed.connect(play_note_action)
	randomize_key_button.pressed.connect(randomize_key_action)
	randomize_mode_button.pressed.connect(randomize_mode_action)
#endregion
