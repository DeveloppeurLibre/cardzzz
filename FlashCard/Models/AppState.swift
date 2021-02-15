//
//  AppState.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import Foundation

class AppState: ObservableObject {
	@Published var userData = UserData()
	
	static var preview: AppState {
		let state = AppState()
		state.userData.decks = Deck.mockedData
		state.userData.categories = FlashCardCategory.mockedData
		return state
	}
}

extension AppState {
	struct UserData {
		var decks: [Deck] = []
		var categories: [FlashCardCategory] = []
	}
}
