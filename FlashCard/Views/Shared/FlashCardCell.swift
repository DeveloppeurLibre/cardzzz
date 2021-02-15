//
//  FlashCardCell.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import SwiftUI

struct FlashCardCell: View {
	
	let card: FlashCard
	
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
				Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
					Image(systemName: "pencil.circle")
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
	
    static var previews: some View {
		FlashCardCell(card: card)
    }
}
