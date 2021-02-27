//
//  FlashCardsRepository.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import Foundation

protocol FlashCardsRepository {
	func loadDecks(for userID: String, completion: @escaping (WebResponse<[RestDeck]>) -> Void)
	func update(card: RestFlashCard, in deck: RestDeck, for userID: String, completion: @escaping (WebResponse<Void>) -> Void)
	func update(deck: RestDeck, for userID: String, completion: @escaping (WebResponse<Void>) -> Void)
	func remove(deck: RestDeck, for userID: String, completion: @escaping (WebResponse<Void>) -> Void)
	func update(cardID: String, deckID: String, feedback: Feedback, for userID: String, completion: @escaping (WebResponse<Void>) -> Void)
}
