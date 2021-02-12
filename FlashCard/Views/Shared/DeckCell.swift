//
//  DeckCell.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import SwiftUI

struct DeckCell: View {
	
	@ObservedObject var deck: Deck
	@State private var isPresentingSessionScreen = false
	
	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text(deck.name)
					.font(.title3)
					.fontWeight(.semibold)
				Text("\(deck.cards.count) cartes")
					.foregroundColor(.gray)
			}
			Spacer()
			Button(action: {
				isPresentingSessionScreen.toggle()
			}, label: {
				Image(systemName: "play.circle")
					.font(.system(size: 28, weight: .semibold))
					.foregroundColor(.green)
			})
			.fullScreenCover(isPresented: $isPresentingSessionScreen, content: {
				SessionScreen(deck: deck)
			})
		}
		.padding()
    }
}

struct DeckCell_Previews: PreviewProvider {
	
    static var previews: some View {
		DeckCell(deck: Deck.mockedData.first!)
			.previewLayout(.sizeThatFits)
    }
}
