//
//  Tones.swift
//  NachSpiel
//
//  Created by Timm Knape on 17.06.22.
//

import Foundation

let baseMidiC = 72
let notesPerOctave = 12
let nextMidiC = baseMidiC + notesPerOctave

func noteName(midiCode: Int, preferSharp: Bool) -> String {
	var effectiveCode = midiCode
	while effectiveCode < baseMidiC { effectiveCode += notesPerOctave }
	while effectiveCode >= nextMidiC { effectiveCode -= notesPerOctave }
	switch effectiveCode - baseMidiC {
	case 0: return "C"
	case 1: return preferSharp ? "C#" : "Db"
	case 2: return "D"
	case 3: return preferSharp ? "D#" : "Eb"
	case 4: return "E"
	case 5: return "F"
	case 6: return preferSharp ? "F#" : "Gb"
	case 7: return "G"
	case 8: return preferSharp ? "G#" : "Ab"
	case 9: return "A"
	case 10: return preferSharp ? "A#" : "Bb"
	case 11: return "B"
	default: return "??"
	}
}

let major_intervals = [ 0, 2, 4, 5, 7, 9, 11 ]
let minor_intervals = [ 0, 2, 3, 5, 7, 8, 10 ]

struct Scale {
	let midiBase: Int
	let withSharp: Bool
	let major: Bool
	
	func midiNoteInScale(index: Int) -> Int {
		var effectiveIndex = index
		while effectiveIndex <= 0 { effectiveIndex += 7 }
		while effectiveIndex >= 8 { effectiveIndex -= 7 }
		effectiveIndex -= 1
		return midiBase + (major ? major_intervals[effectiveIndex] : minor_intervals[effectiveIndex])
	}
	
	func nameInScale(index: Int) -> String {
		return noteName(midiCode: midiNoteInScale(index: index), preferSharp: withSharp).uppercased()
	}
	
	var name: String {
		get {
			let name = noteName(midiCode: midiBase, preferSharp: withSharp)
			let castedName = major ? name.uppercased() : name.lowercased()
			return "\(castedName) \(major ? "major" : "minor")"
		}
	}
}

let trainingScales = [
	// C, a, G, e, F, d,
	Scale(midiBase: baseMidiC, withSharp: true, major: true),
	Scale(midiBase: baseMidiC - 3, withSharp: true, major: false),
	Scale(midiBase: baseMidiC + 7, withSharp: true, major: true),
	Scale(midiBase: baseMidiC + 4, withSharp: true, major: false),
	Scale(midiBase: baseMidiC + 5, withSharp: false, major: true),
	Scale(midiBase: baseMidiC + 2, withSharp: true, major: false)
]

struct Interval : Identifiable {
	var id: Int
}

let trainingIntervals = [ Interval(id: 1), Interval(id: 3), Interval(id: 5), Interval(id: 7) ]
