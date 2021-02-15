//
//  InteractorContainers.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import SwiftUI

class InteractorsContainer: EnvironmentKey {
	
	let authInteractor: AuthInteractor
	let deckInteractor: DeckInteractor
	
	init(authInteractor: AuthInteractor,
		 deckInteractor: DeckInteractor) {
		self.authInteractor = authInteractor
		self.deckInteractor = deckInteractor
	}
	
	static var defaultValue: InteractorsContainer {
		return .init(
			authInteractor: AuthInteractorImplementation(),
			deckInteractor: DeckInteractorImplementation(flashCardsRepository: FirebaseFlashCardsRepository())
		)
	}
	
	static func local(appState: AppState) -> InteractorsContainer {
		return .init(
			authInteractor: AuthInteractorImplementation(),
			deckInteractor: DeckInteractorImplementation(flashCardsRepository: FirebaseFlashCardsRepository())
		)
	}
}

extension EnvironmentValues {
	var interactors: InteractorsContainer {
		get { self[InteractorsContainer.self] }
		set { self[InteractorsContainer.self] = newValue }
	}
}
