//
//  DeckInteractorImplementation.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import Foundation
import Firebase

protocol DeckInteractor {
	func loadDecks(completion: @escaping (WebResponse<[Deck]>) -> Void)
	func update(deck: Deck)
	func remove(deck: Deck)
	func update(feedback: Feedback, for card: FlashCard, in deck: Deck)
	func getCardsToRecall(deck: Deck) -> [FlashCard]
}

class DeckInteractorImplementation: DeckInteractor {
	
	private let flashCardsRepository: FlashCardsRepository
	
	init(flashCardsRepository: FlashCardsRepository) {
		self.flashCardsRepository = flashCardsRepository
	}
	
	func loadDecks(completion: @escaping (WebResponse<[Deck]>) -> Void) {
		guard let currentUser = Auth.auth().currentUser else { return }
		flashCardsRepository.loadDecks(for: currentUser.uid) { response in
			switch response {
				case .success(response: let restDecks):
					var decks = [Deck]()
					for restDeck in restDecks {
						decks.append(
							Deck(
								id: restDeck.id,
								name: restDeck.name,
								cards: self.map(restFlashCards: restDeck.cards)
							)
						)
					}
					completion(.success(response: decks))
				case .failure(error: let error):
					print(error.localizedDescription)
			}
		}
	}
	
	func update(deck: Deck) {
		guard let currentUser = Auth.auth().currentUser else { return }
		let restDeck = RestDeck(
			id: deck.id,
			name: deck.name,
			cards: map(flashCard: deck.cards)
		)
		
		flashCardsRepository.update(deck: restDeck, for: currentUser.uid) { response in
			// TODO: (Quentin Cornu) To handle
		}
	}
	
	func remove(deck: Deck) {
		guard let currentUser = Auth.auth().currentUser else { return }
		let restDeck = RestDeck(
			id: deck.id,
			name: deck.name,
			cards: map(flashCard: deck.cards)
		)
		
		flashCardsRepository.remove(deck: restDeck, for: currentUser.uid) { response in
			// TODO: (Quentin Cornu) To handle
		}
	}
	
	func update(feedback: Feedback, for card: FlashCard, in deck: Deck) {
		guard let currentUser = Auth.auth().currentUser else { return }
		card.boxNumber = feedback.boxNumber
		card.lastUpdateDate = feedback.lastUpdateDate
		deck.objectWillChange.send()
		flashCardsRepository.update(cardID: card.id, deckID: deck.id, feedback: feedback, for: currentUser.uid) { response in
			// TODO: (Quentin Cornu) To handle
		}
	}
	
	func getCardsToRecall(deck: Deck) -> [FlashCard] {
		let now = Date()
		return deck.cards.filter { $0.nextDate() < now }
	}
	
	private func map(flashCard: [FlashCard]) -> [RestFlashCard] {
		var restFlashCards = [RestFlashCard]()
		for card in flashCard {
			restFlashCards.append(
				RestFlashCard(
					id: card.id,
					question: card.question,
					response: card.response,
					categoryID: card.category?.id.uuidString ?? "",
					boxNumber: card.boxNumber,
					lastUpdateDate: Timestamp(date: card.lastUpdateDate)
				)
			)
		}
		return restFlashCards
	}
	
	private func map(restFlashCards: [RestFlashCard]) -> [FlashCard] {
		var flashCards = [FlashCard]()
		for restCard in restFlashCards {
			flashCards.append(
				FlashCard(
					id: restCard.id,
					question: restCard.question,
					response: restCard.response,
					boxNumber: restCard.boxNumber,
					lastUpdateDate: restCard.lastUpdateDate.dateValue()
				)
			)
		}
		return flashCards
	}
}
