//
//  MockedData.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import Foundation

extension FlashCard {
	static let mockedData: [FlashCard] = [
		FlashCard(id: UUID().uuidString, question: "Question 1", response: "Response 1", category: FlashCardCategory(name: "Category 1", color: .red), boxNumber: 1, lastUpdateDate: Date()),
		FlashCard(id: UUID().uuidString, question: "Question 2", response: "Response 2", category: FlashCardCategory(name: "Category 2", color: .orange), boxNumber: 1, lastUpdateDate: Date()),
		FlashCard(id: UUID().uuidString, question: "Question 3", response: "Response 3", boxNumber: 2, lastUpdateDate: Date()),
		FlashCard(id: UUID().uuidString, question: "Question 4", response: "Response 4", boxNumber: 3, lastUpdateDate: Date()),
		FlashCard(id: UUID().uuidString, question: "Question 5", response: "Response 5", category: FlashCardCategory(name: "Category 3", color: .blue), boxNumber: 4, lastUpdateDate: Date())
	]
}

extension Deck {
	static let mockedData: [Deck] = [
		Deck(id: UUID().uuidString, name: "Deck name 1", cards: FlashCard.mockedData),
		Deck(id: UUID().uuidString, name: "Deck name 2", cards: FlashCard.mockedData),
		Deck(id: UUID().uuidString, name: "Deck name 3", cards: FlashCard.mockedData),
		Deck(id: UUID().uuidString, name: "Deck name 4", cards: FlashCard.mockedData),
		Deck(id: UUID().uuidString, name: "Deck name 5", cards: FlashCard.mockedData)
	]
}

extension FlashCardCategory {
	static let mockedData: [FlashCardCategory] = [
		FlashCardCategory(name: "School", color: .orange),
		FlashCardCategory(name: "iOS dev", color: .green),
		FlashCardCategory(name: "Videography", color: .purple)
	]
}
