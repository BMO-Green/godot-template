extends Resource
class_name MusicBank

const chord_progressions = {
	"C" : {
		"ionian" : [
			{"key": "C", "mode" : "aeolian"},
			{"key": "A", "mode" : "aeolian"},
			{"key": "A", "mode" : "lydian"},
			{"key": "F", "mode" : "aeolian"},
			{"key": "G", "mode" : "ionian"},
		],
		"aeolian" : [
			{"key": "C", "mode" : "ionian"},
		],
		"mixolydian" : [
			{"key": "F", "mode" : "dorian"},
		],
	},
	"C#" : {
		"phrygian" : [
			{"key": "F#", "mode" : "aeolian"},
		],
		"lydian" : [
			{"key": "D#", "mode" : "mixolydian"},
			{"key": "F", "mode" : "mixolydian"},
		],
	},
	"D" : {
		"phrygian" : [
			{"key" : "D#", "mode" : "lydian"},
		],
		"lydian" : [
			{"key": "F#", "mode" : "dorian"},
		],
		"mixolydian" : [
			{"key": "B", "mode" : "ionian"},
		],
	},
	"D#" : {
		"dorian" : [
			{"key" : "F", "mode" : "aeolian"},
			{"key" : "F#", "mode" : "aeolian"},
			
		],
		"lydian" : [
			{"key" : "B", "mode" : "dorian"},
			{"key" : "D#", "mode" : "phrygian"},
		],
		"mixolydian" : [
			{"key" : "C#", "mode" : "lydian"},
		],
		"phrygian" : [
			{"key" : "D#", "mode" : "mixolydian"},
		],
		"aeolian" : [
			{"key" : "E", "mode" : "lydian"},
			{"key" : "A", "mode" : "ionian"},
		],
	},
	"E" : {
		"dorian" : [
			{"key": "E", "mode" : "mixolydian"},
		],
		"mixolydian" : [
			{"key": "D#", "mode" : "lydian"},
			{"key": "F", "mode" : "ionian"},
		],
		"lydian" : [
			{"key": "E", "mode" : "aeolian"},
		],
	},
	"F" : {
		"ionian" : [
			{"key" : "D#", "mode" : "dorian"},
		],
		"mixolydian" : [
			{"key" : "G#", "mode" : "mixolydian"},
		],
		"aeolian" : [
			{"key" : "C", "mode" : "ionian"},
			{"key" : "C", "mode" : "lydian"},
			{"key" : "F", "mode" : "ionian"},
		],
	},
	"F#" : {
		"dorian" : [
			{"key": "D", "mode" : "phrygian"},
			{"key": "D#", "mode" : "mixolydian"},
		],
		"lydian" : [
			{"key": "B", "mode" : "dorian"}
		],
		"aeolian" : [
			{"key": "D#", "mode" : "dorian"},
			{"key": "D#", "mode" : "dorian"},
		],
	},
	"G" : {
		"ionian" : [
			{"key": "C", "mode" : "ionian"},
		],
		"dorian" : [
			{"key": "A", "mode" : "aeolian"},
		],
	},
	"G#" : {
		"ionian" : [
			{"key": "F#", "mode" : "dorian"},
		],
		"dorian" : [
			{"key": "C#", "mode" : "phrygian"},
			{"key": "F#", "mode" : "phrygian"},
		],
		"mixolydian" : [
			{"key": "A", "mode" : "ionian"},
		],
	},
	"A" : {
		"ionian": [
			{"key": "G", "mode" : "ionian"},
			{"key": "D", "mode" : "mixolydian"},
		],
		"lydian": [
			{"key": "G#", "mode" : "mixolydian"},
		],
		"aeolian" : [
			{"key" : "C", "mode" : "ionian"},
			{"key" : "A#", "mode" : "lydian"}
		],
	},
	"A#" : {
		"dorian" : [
			{"key" : "A", "mode" : "lydian"},
		],
		"lydian" : [
			{"key" : "G#", "mode" : "ionian"},
		],
	},
	"B" : {
		"lydian" : [
			{"key" : "D#", "mode" :"dorian" },
			{"key" : "F#", "mode" :"ionian" },
		],
		"dorian" : [
			{"key" : "G#", "mode" :"dorian" },
		],
	},
}
