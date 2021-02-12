//
//  DeckDetail.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import SwiftUI

struct DeckDetailScreen: View {
	
	@EnvironmentObject var appState: AppState
	@ObservedObject var deck: Deck
	@Environment(\.presentationMode) var presentationMode
	@Environment(\.interactors) var interactors: InteractorsContainer
	
	var body: some View {
		VStack(alignment: .leading, spacing: 32) {
			VStack(alignment: .leading) {
				Text(getTitle())
					.font(.title)
					.fontWeight(.bold)
					.padding(.top)
			}
			TextField("Name your deck", text: $deck.name)
				.textFieldStyle(RoundedBorderTextFieldStyle())
			Spacer()
			HStack {
				MainButton(title: "Cancel", color: .red) {
					presentationMode.wrappedValue.dismiss()
				}
				MainButton(title: "Save", color: .blue) {
					interactors.deckInteractor.update(deck: deck)
					presentationMode.wrappedValue.dismiss()
					appState.userData.decks.append(deck)
				}
			}
		}
		.padding()
	}
	
	private func getTitle() -> String {
		if deck.name.isEmpty {
			return "Name your Deck"
		} else {
			return deck.name
		}
	}
}

struct DeckDetail_Previews: PreviewProvider {
	static var previews: some View {
		DeckDetailScreen(deck: Deck(id: UUID().uuidString, name: ""))
	}
}
