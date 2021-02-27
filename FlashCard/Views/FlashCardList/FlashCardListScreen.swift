//
//  FlashCardListScreen.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import SwiftUI

struct FlashCardListScreen: View {
	
	@EnvironmentObject var appState: AppState
	@ObservedObject var deck: Deck
	@State private var isPresentingCardCreationScreen: Bool = false
	@State private var isPresentingAlert: Bool = false
	@Environment(\.presentationMode) var presentationMode
	@Environment(\.interactors) var interactors: InteractorsContainer
	
    var body: some View {
		ZStack(alignment: .bottomTrailing) {
			ScrollView {
				VStack {
					ForEach(deck.cards) { card in
						FlashCardCell(card: card, deck: deck)
						Divider()
					}
				}
			}
			HStack {
				Spacer()
				FloatingButton(iconName: "plus", color: .blue) {
					isPresentingCardCreationScreen.toggle()
				}
			}
			.padding()
			.sheet(isPresented: $isPresentingCardCreationScreen, content: {
				FlashCardDetailScreen(
					mode: .presentation(deck: deck),
					categories: [],
					card: FlashCard(id: UUID().uuidString, question: "", response: "", boxNumber: 1, lastUpdateDate: Date()),
					deck: deck
				)
			})
		}
		.navigationTitle(deck.name)
		.navigationBarItems(
			trailing: Button(action: {
				isPresentingAlert.toggle()
			}, label: {
				Image(systemName: "trash")
			})
			.alert(isPresented: $isPresentingAlert, content: {
				Alert(
					title: Text("Are you sure?"),
					message: Text("Are you sure to remove this deck? If yes, all of your cards will be lost... 😔"),
					primaryButton: .cancel(),
					secondaryButton: .destructive(Text("Remove"), action: {
						appState.userData.decks.removeAll { $0.id == deck.id }
						interactors.deckInteractor.remove(deck: deck)
						presentationMode.wrappedValue.dismiss()
					})
				)
			})
		)
    }
}

struct FlashCardListScreen_Previews: PreviewProvider {
    static var previews: some View {
		FlashCardListScreen(deck: Deck.mockedData.first!)
    }
}
