extends Resource
class_name MusicData

enum KEYS { C, Cs, Ds, D, E, F, Fs, G, Gs, A, As, B,}
enum MODES { IONIAN, DORIAN, PHRYGIAN, LYDIAN, MIXOLYDIAN, AEOLIAN,}
enum SCALE_VARIANT { DIATONIC = 0, PENTATONIC = 1,}


## ===== KEYS =====
# Returns random KEY enum
func get_random_key() -> KEYS:
	var random_key = KEYS.keys()[randi() % KEYS.size()]
	return KEYS[random_key]

# Returns pitch scale float given KEY enum
func get_key_scale(key : KEYS) -> float:
	return KEY_SCALES[key]

# Returns KEY name as string
func get_key_string(key : KEYS) -> String:
	return KEY_STRINGS[key]
	
# Returns KEY enum given key_string name value
func get_key(key_string : String) -> KEYS:
	return KEYS.find_key(key_string)


## ===== MODES =====
# Returns random MODES enum
func get_random_mode() -> MODES:
	var random_mode = MODES.keys()[randi() % MODES.size()]
	return MODES[random_mode]

# Returns MODE name as string
func get_mode_string(mode : MODES) -> String:
	return MODES_DICT[mode].name

# Returns an array of note interval scales given MODE
func get_mode_intervals(mode : MODES = MODES.IONIAN) -> Array:
	return MODES_DICT_DIATONIC[get_mode_string(mode)]
	
# Returns an array of note interval scales given SCALE VARIANT
func get_mode_scale_variant_intervals(mode : MODES = MODES.IONIAN, scale_variant : SCALE_VARIANT = SCALE_VARIANT.DIATONIC):
	match scale_variant:
		SCALE_VARIANT.DIATONIC:
			return MODES_DICT_DIATONIC[get_mode_string(mode)]
		SCALE_VARIANT.PENTATONIC:
			return MODES_DICT_PENTATONIC[get_mode_string(mode)]
	


## OBSOLETE
#func get_mode(mode_string : String, scale_variant : SCALE_VARIANT, weighted: bool) -> Array:
	#return MODES_DICT_DIATONIC[mode_string]
	#
	#match scale_variant:
		#SCALE_VARIANT.DIATONIC:
			#return MODES_DICT_DIATONIC[mode_string]
		#SCALE_VARIANT.PENTATONIC:
			#return MODES_DICT_MODES_DICT_PENTATONIC[mode_string]
	#if weighted:
		#return MODES_DICT_WEIGHTED[mode_string]
	#else:
		#return MODES_DICT_MODES_DICT_PENTATONIC[mode_string]
	#
#func get_mode_MODES_DICT_PENTATONIC(mode_string: String):
	#return MODES_DICT_MODES_DICT_PENTATONIC[mode_string]
#
#func get_mode_weighted(mode_string : String):
	#return MODES_DICT_WEIGHTED[mode_string]



const KEY_STRINGS = {
	KEYS.C  : "C",
	KEYS.Cs : "C#",
	KEYS.Ds : "D",
	KEYS.D  : "D#",
	KEYS.E  : "E",
	KEYS.F  : "F",
	KEYS.Fs : "F#",
	KEYS.G  : "G",
	KEYS.Gs : "G#",
	KEYS.A  : "A",
	KEYS.As : "A#",
	KEYS.B  : "B",
}

const KEY_SCALES = {
	KEYS.C  : 1,
	KEYS.Cs : 1.0625,
	KEYS.Ds : 1.125,
	KEYS.D  : 1.1875,
	KEYS.E  : 1.25,
	KEYS.F  : 1.3225,
	KEYS.Fs : 1.4375,
	KEYS.G  : 1.5,
	KEYS.Gs : 1.5825,
	KEYS.A  : 1.6875,
	KEYS.As : 1.8125,
	KEYS.B  : 1.9375,
}

# Intervals to pitch bass
const note_intervals = {
	"prime" : 1,
	"minor second" : 1.0625,
	"major second" : 1.125,
	"minor third" : 1.1875,
	"major third" : 1.25,
	"fourth" : 1.3125,
	"tritone" : 1.4375,
	"fifth" : 1.5,
	"minor sixth" : 1.625,
	"major sixth" : 1.6875,
	"minor seventh" : 1.75,
	"major seventh" : 1.875,
}

const MODES_DICT = {
	MODES.IONIAN : {
		name = "ionian",
		notes = [
			note_intervals["prime"],
			note_intervals["major second"],
			note_intervals["major third"],
			note_intervals["fourth"],
			note_intervals["fifth"],
			note_intervals["major sixth"],
			note_intervals["major seventh"],
		]
	},
	MODES.DORIAN : {
		name = "dorian",
		notes = [
			note_intervals["prime"],
			note_intervals["major second"],
			note_intervals["minor third"],
			note_intervals["fourth"],
			note_intervals["fifth"],
			note_intervals["major sixth"],
			note_intervals["minor seventh"],
		],
	},
	MODES.PHRYGIAN : {
		name = "phrygian",
		notes = [
			note_intervals["prime"],
			note_intervals["minor second"],
			note_intervals["minor third"],
			note_intervals["fourth"],
			note_intervals["fifth"],
			note_intervals["minor sixth"],
			note_intervals["minor seventh"],
		],
	},
	MODES.LYDIAN : {
		name = "lydian",
		notes = [
			note_intervals["prime"],
			note_intervals["major second"],
			note_intervals["major third"],
			note_intervals["tritone"],
			note_intervals["fifth"],
			note_intervals["major sixth"],
			note_intervals["major seventh"],
		],
	},
	MODES.MIXOLYDIAN : {
		name = "mixolydian",
		notes = [
			note_intervals["prime"],
			note_intervals["major second"],
			note_intervals["major third"],
			note_intervals["fourth"],
			note_intervals["fifth"],
			note_intervals["minor sixth"],
			note_intervals["minor seventh"],
		],
	},
	MODES.AEOLIAN : {
		name = "aeolian",
		notes = [
			note_intervals["prime"],
			note_intervals["major second"],
			note_intervals["minor third"],
			note_intervals["fourth"],
			note_intervals["fifth"],
			note_intervals["minor sixth"],
			note_intervals["minor seventh"],
		],
	}
}

const MODES_DICT_DIATONIC = {
	"ionian" = [
		note_intervals["prime"],
		note_intervals["major second"],
		note_intervals["major third"],
		note_intervals["fourth"],
		note_intervals["fifth"],
		note_intervals["major sixth"],
		note_intervals["major seventh"],
	],
	"dorian" = [
		note_intervals["prime"],
		note_intervals["major second"],
		note_intervals["minor third"],
		note_intervals["fourth"],
		note_intervals["fifth"],
		note_intervals["major sixth"],
		note_intervals["minor seventh"],
	],
	"phrygian" = [
		note_intervals["prime"],
		note_intervals["minor second"],
		note_intervals["minor third"],
		note_intervals["fourth"],
		note_intervals["fifth"],
		note_intervals["minor sixth"],
		note_intervals["minor seventh"],
	],
	"lydian" = [
		note_intervals["prime"],
		note_intervals["major second"],
		note_intervals["major third"],
		note_intervals["tritone"],
		note_intervals["fifth"],
		note_intervals["major sixth"],
		note_intervals["major seventh"],
	],
	"mixolydian" = [
		note_intervals["prime"],
		note_intervals["major second"],
		note_intervals["major third"],
		note_intervals["fourth"],
		note_intervals["fifth"],
		note_intervals["minor sixth"],
		note_intervals["minor seventh"],
	],
	"aeolian" = [
		note_intervals["prime"],
		note_intervals["major second"],
		note_intervals["minor third"],
		note_intervals["fourth"],
		note_intervals["fifth"],
		note_intervals["minor sixth"],
		note_intervals["minor seventh"],
	]
}

const MODES_DICT_PENTATONIC = {
	"ionian" = [
		note_intervals["prime"],
		#note_intervals["major second"],
		note_intervals["major third"],
		note_intervals["fourth"],
		note_intervals["fifth"],
		#note_intervals["major sixth"],
		note_intervals["major seventh"],
	],
	"dorian" = [
		note_intervals["prime"],
		note_intervals["major second"],
		note_intervals["minor third"],
		#note_intervals["fourth"],
		note_intervals["fifth"],
		note_intervals["major sixth"],
		#note_intervals["minor seventh"],
	],
	"phrygian" = [
		note_intervals["prime"],
		note_intervals["minor second"],
		#note_intervals["minor third"],
		note_intervals["fourth"],
		note_intervals["fifth"],
		#note_intervals["minor sixth"],
		note_intervals["minor seventh"],
	],
	"lydian" = [
		note_intervals["prime"],
		#note_intervals["major second"],
		note_intervals["major third"],
		note_intervals["tritone"],
		note_intervals["fifth"],
		#note_intervals["major sixth"],
		note_intervals["major seventh"],
	],
	"mixolydian" = [
		note_intervals["prime"],
		#note_intervals["major second"],
		note_intervals["major third"],
		#note_intervals["fourth"],
		note_intervals["fifth"],
		note_intervals["major sixth"],
		note_intervals["minor seventh"],
	],
	"aeolian" = [
		note_intervals["prime"],
		note_intervals["major second"],
		note_intervals["minor third"],
		#note_intervals["fourth"],
		note_intervals["fifth"],
		note_intervals["minor sixth"],
		#note_intervals["minor seventh"],
	]
}

## TODO_UPDATE
const MODES_DICT_WEIGHTED = {
	"ionian" = [
		{"pitch" : note_intervals["prime"], "probability" : 1},
		{"pitch" : note_intervals["major second"], "probability" : .2},
		{"pitch" : note_intervals["major third"], "probability" : .6},
		{"pitch" : note_intervals["fourth"], "probability" : .3},
		{"pitch" : note_intervals["fifth"], "probability" : .8},
		{"pitch" : note_intervals["major sixth"], "probability" : .1},
		{"pitch" : note_intervals["major seventh"], "probability" : .3},
	],
	"dorian" = [
		note_intervals["prime"],
		note_intervals["major second"],
		note_intervals["minor third"],
		#note_intervals["fourth"],
		note_intervals["fifth"],
		note_intervals["major sixth"],
		#note_intervals["minor seventh"],
	],
	"phrygian" = [
		note_intervals["prime"],
		note_intervals["minor second"],
		#note_intervals["minor third"],
		note_intervals["fourth"],
		note_intervals["fifth"],
		#note_intervals["minor sixth"],
		note_intervals["minor seventh"],
	],
	"lydian" = [
		note_intervals["prime"],
		#note_intervals["major second"],
		note_intervals["major third"],
		note_intervals["tritone"],
		note_intervals["fifth"],
		#note_intervals["major sixth"],
		note_intervals["major seventh"],
	],
	"mixolydian" = [
		note_intervals["prime"],
		#note_intervals["major second"],
		note_intervals["major third"],
		#note_intervals["fourth"],
		note_intervals["fifth"],
		note_intervals["major sixth"],
		note_intervals["minor seventh"],
	],
	"aeolian" = [
		note_intervals["prime"],
		note_intervals["major second"],
		note_intervals["minor third"],
		#note_intervals["fourth"],
		note_intervals["fifth"],
		note_intervals["minor sixth"],
		#note_intervals["minor seventh"],
	]
}
