//
//  FirebaseFlashCardsRepository.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import Foundation
import FirebaseFirestore

class FirebaseFlashCardsRepository: FlashCardsRepository {
	
	let database = Firestore.firestore()
	
	func loadDecks(for userID: String, completion: @escaping (WebResponse<[RestDeck]>) -> Void) {
		let collection = database.collection("users").document(userID).collection("decks")
		collection.getDocuments { (querySnapshot, error) in
			if let error = error {
				print("Error getting documents: \(error)")
			} else {
				var restDecks = [RestDeck]()
				for document in querySnapshot!.documents {
					collection.document(document.documentID).collection("cards").getDocuments { (querySnapshot, error) in
						if let error = error {
							print("Error getting documents: \(error)")
						} else {
							var restCards = [RestFlashCard]()
							for document in querySnapshot!.documents {
								restCards.append(
									RestFlashCard(
										id: document.documentID,
										question: document["question"] as? String ?? "",
										response: document["response"] as? String ?? "",
										categoryID: "",
										boxNumber: document["boxNumber"] as? Int ?? 1,
										lastUpdateDate: document["lastUpdateDate"] as? Date ?? Date()
									)
								)
							}
							restDecks.append(
								RestDeck(
									id: document.documentID,
									name: document["name"] as? String ?? "",
									cards: restCards
								)
							)
							completion(.success(response: restDecks))
						}
					}
				}
			}
		}
	}
	
	func update(deck: RestDeck, for userID: String, completion: @escaping (WebResponse<Void>) -> Void) {
		let document = database.collection("users").document(userID).collection("decks").document(deck.id)
		
		document.setData([
			"name": deck.name
		])
		for card in deck.cards {
			document.collection("cards").document(card.id).setData([
				"question": card.question,
				"response": card.response
			])
		}
	}
	
	func remove(deck: RestDeck, for userID: String, completion: @escaping (WebResponse<Void>) -> Void) {
		let document = database.collection("users").document(userID).collection("decks").document(deck.id)
		document.delete()
	}
	
	func update(cardID: String, deckID: String, feedback: Feedback, for userID: String, completion: @escaping (WebResponse<Void>) -> Void) {
		let document = database.collection("users").document(userID).collection("decks").document(deckID).collection("cards").document(cardID)
		document.setData([
			"boxNumber": feedback.boxNumber,
			"lastUpdateDate": feedback.lastUpdateDate
		], merge: true)
	}
}
