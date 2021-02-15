//
//  FlashCardDetailScreen.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import SwiftUI

struct FlashCardDetailScreen: View {
	
	let deck: Deck
	let mode: ScreenMode
	let categories: [FlashCardCategory]
	@ObservedObject var card: FlashCard
	@EnvironmentObject var appState: AppState
	@Environment(\.presentationMode) var presentationMode
	@Environment(\.interactors) var interactors: InteractorsContainer
	
	var body: some View {
		VStack {
			VStack(alignment: .leading) {
				Text(getTitle())
					.font(.title)
					.fontWeight(.bold)
					.padding(.vertical)
				VStack {
					HeadedTextEditor(header: "Question", text: $card.question)
					HeadedTextEditor(header: "Response", text: $card.response)
				}
			}
			.padding()
			ScrollView(.horizontal) {
				HStack {
					ForEach(categories) { category in
						CategoryPill(category: category, format: .selectable)
					}
				}
				.padding(.leading)
			}
			MainButton(title: getButtonTitle(), color: .blue) {
				deck.cards.append(card)
				interactors.deckInteractor.update(deck: deck)
				presentationMode.wrappedValue.dismiss()
			}
			.padding()
		}
	}
	
	private func getTitle() -> String {
		switch mode {
			case .edition:
				return "Add a new card"
			case .presentation:
				return "Card Details"
		}
	}
	
	private func getButtonTitle() -> String {
		switch mode {
			case .edition:
				return "Save"
			case .presentation:
				return "Edit"
		}
	}
}

struct FlashCardDetailScreen_Previews: PreviewProvider {
	
	@State static var newCard = FlashCard(id: UUID().uuidString, question: "", response: "", boxNumber: 1, lastUpdateDate: Date())
	
	static var previews: some View {
		Group {
			FlashCardDetailScreen(
				deck: Deck(id: UUID().uuidString, name: ""),
				mode: .edition,
				categories: FlashCardCategory.mockedData,
				card: newCard
			)
			FlashCardDetailScreen(
				deck: Deck(id: UUID().uuidString, name: ""),
				mode: .presentation,
				categories: FlashCardCategory.mockedData,
				card: FlashCard.mockedData.first!
			)
		}
	}
}
