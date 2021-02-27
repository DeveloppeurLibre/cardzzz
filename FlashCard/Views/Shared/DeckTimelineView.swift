//
//  DeckTimelineView.swift
//  FlashCard
//
//  Created by Quentin Cornu on 15/02/2021.
//

import SwiftUI

struct DeckTimelineView: View {
	
	@ObservedObject var deck: Deck
	
    var body: some View {
		HStack(spacing: 4) {
			ForEach(getTimeline().sorted(by: <), id: \.key) { day, number in
				Text("\(number) \(day.name)")
					.foregroundColor(day.color)
			}
		}
    }
	
	private func getTimeline() -> [Day: Int] {
		var timeline = [0: 0, 1: 0, 2: 0]
		let dayInterval = TimeInterval(60 * 60 * 24)
		
		for card in deck.cards {
			if card.nextDate() < Date() {
				timeline[0]! += 1
			} else if card.nextDate() < Date() + dayInterval {
				timeline[1]! += 1
			} else {
				timeline[2]! += 1
			}
		}
		return timeline
	}
}

fileprivate typealias Day = Int

fileprivate extension Day {
	var name: String {
		switch self {
			case 0:
				return "tod."
			case 1:
				return "tom."
			default:
				return "later"
		}
	}
	
	var color: Color {
		switch self {
			case 0:
				return .red
			case 1:
				return .orange
			default:
				return .blue
		}
	}
}

struct DeckTimelineView_Previews: PreviewProvider {
    static var previews: some View {
		DeckTimelineView(deck: Deck.mockedData[0])
    }
}
