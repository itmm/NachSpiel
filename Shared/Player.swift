import Foundation
import AudioToolbox

class Player {
	private static var player: MusicPlayer?
	
	init() {
		if Player.player == nil {
			NewMusicPlayer(&Player.player)
		}
	}
	func play(_ midiNotes: [Int]) {
		if let player = Player.player {
			stop()
			var sequence: MusicSequence?
			NewMusicSequence(&sequence)
			var track: MusicTrack?
			MusicSequenceNewTrack(sequence!, &track)
			var time = MusicTimeStamp(0.0)
			for midiNote in midiNotes {
				var note = MIDINoteMessage(
					channel: 0, note: UInt8(midiNote), velocity: 127,
					releaseVelocity: 0, duration: 1.0
				)
				MusicTrackNewMIDINoteEvent(track!, time, &note)
				time = time.advanced(by: 1.0)
			}
			MusicPlayerSetSequence(player, sequence)
			MusicPlayerStart(player)
		}
	}
	
	func stop() {
		if let player = Player.player {
			MusicPlayerStop(player)
		}
	}
}
