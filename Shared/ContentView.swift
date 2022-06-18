import SwiftUI

struct ContentView: View {
	@State private var scale: Scale = trainingScales[0]

	private var player = Player()
	
	func play(interval: Int) {
		player.play([scale.midiNoteInScale(index: interval)])
	}
	
	func newGame() {
		let idx = (0 ..< trainingScales.count).randomElement()
		scale = trainingScales[idx!]
	}

	var body: some View {
		NavigationView {
			Form {
				Section {
					Text("Key: \(scale.name)")
				}
				Section {
					Text("Tones in Scale")
					ForEach(trainingIntervals) { idx in
						Button() {
							play(interval: idx.id)
						} label: {
							Text("\(idx.id)  \(scale.nameInScale(index: idx.id))")
						}
					}
				}
				Section {
					Button(action: newGame) {
						Text("New Game")
					}
				}
			}.navigationTitle("NachSpiel")
				.navigationBarTitleDisplayMode(.inline)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
