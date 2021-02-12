//
//  Deck.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import Foundation
import Combine

class Deck: Identifiable, ObservableObject {
	let id: String
	@Published var name: String
	@Published var cards: [FlashCard]
	
	init(id: String, name: String, cards: [FlashCard] = []) {
		self.id = id
		self.name = name
		self.cards = cards
	}
}
