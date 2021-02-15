//
//  FlashCard.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import Foundation
import Combine

class FlashCard: Identifiable, ObservableObject {
	let id: String
	@Published var question: String
	@Published var response: String
	@Published var category: FlashCardCategory?
	@Published var boxNumber: Int
	@Published var lastUpdateDate: Date
	
	init(id: String,
		 question: String, response: String,
		 category: FlashCardCategory? = nil,
		 boxNumber: Int,
		 lastUpdateDate: Date) {
		self.id = id
		self.question = question
		self.response = response
		self.category = category
		self.boxNumber = boxNumber
		self.lastUpdateDate = lastUpdateDate
	}
}
