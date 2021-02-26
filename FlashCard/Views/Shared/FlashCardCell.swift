//
//  FlashCardCell.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import SwiftUI

struct FlashCardCell: View {
	
	@ObservedObject var card: FlashCard
	@ObservedObject var deck: Deck
	@State private var isEditionScreenPresented = false
	
    var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text(card.question)
					.font(.title3)
					.fontWeight(.semibold)
				Text(card.response)
					.foregroundColor(.gray)
			}
			.lineLimit(1)
			Spacer()
			VStack(alignment: .trailing) {
				Button(action: {
					isEditionScreenPresented.toggle()
				}, label: {
					Image(systemName: "pencil.circle")
				})
				.sheet(isPresented: $isEditionScreenPresented, content: {
					FlashCardDetailScreen(mode: .edition, categories: [], card: card, deck: deck)
				})
				if let category = card.category {
					CategoryPill(category: category, format: .caption)
				}
			}
		}
		.padding()
    }
}

struct FlashCardCell_Previews: PreviewProvider {
	
	static let card = FlashCard.mockedData[0]
	static var fakeDeck = Deck(id: "fakeID", name: "Fake Name")
	
    static var previews: some View {
		FlashCardCell(card: card, deck: fakeDeck)
    }
}
