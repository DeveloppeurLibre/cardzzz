//
//  FlashCardApp.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import SwiftUI
import Firebase

@main
struct FlashCardApp: App {
	
	private let appState = AppState()
	
	init() {
		FirebaseApp.configure()
	}
	
	var body: some Scene {
		WindowGroup {
			if Auth.auth().currentUser != nil {
				HomeScreen()
					.environmentObject(appState)
					.environment(\.interactors, InteractorsContainer.local(appState: appState))
			} else {
				LoginScreen()
					.environmentObject(appState)
					.environment(\.interactors, InteractorsContainer.local(appState: appState))
			}
		}
	}
}
