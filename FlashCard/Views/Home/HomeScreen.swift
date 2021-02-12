//
//  HomeScreen.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import SwiftUI
import FirebaseAuth

struct HomeScreen: View {
	
	@EnvironmentObject var appState: AppState
	@State private var isPresentingFlashCardListScreen: Bool = false
	@State private var isPresentingLoginScreen: Bool = false
	@Environment(\.interactors) var interactors: InteractorsContainer
	
	var body: some View {
		NavigationView {
			ZStack(alignment: .bottomTrailing) {
				ScrollView {
					VStack {
						ForEach(appState.userData.decks) { deck in
							Divider()
							NavigationLink(
								destination: FlashCardListScreen(deck: deck),
								label: {
									DeckCell(deck: deck)
								})
						}
					}
					.foregroundColor(.primary)
				}
				.navigationTitle("Révisions")
				.navigationBarItems(
					trailing: Button(action: {
						do {
							try Auth.auth().signOut()
							isPresentingLoginScreen.toggle()
						} catch {
							print("Error signing out")
						}
					}, label: {
						Text("Logout")
							.foregroundColor(.red)
					})
					.fullScreenCover(isPresented: $isPresentingLoginScreen) {
						LoginScreen()
					}
				)
				.listStyle(PlainListStyle())
				HStack {
					Spacer()
					FloatingButton(iconName: "folder.badge.plus", color: .blue) {
						isPresentingFlashCardListScreen.toggle()
					}
				}
				.padding()
				.sheet(isPresented: $isPresentingFlashCardListScreen, content: {
					DeckDetailScreen(deck: Deck(id: UUID().uuidString, name: ""))
				})
			}
			
		}
		.onAppear(perform: {
			interactors.deckInteractor.loadDecks { response in
				switch response {
					case .failure(error: let error):
						print(error.localizedDescription)
					case .success(response: let decks):
						appState.userData.decks = decks
				}
			}
		})
	}
}

struct HomeScreen_Previews: PreviewProvider {
	
	static var previews: some View {
		HomeScreen()
			.environmentObject(AppState.preview)
	}
}
