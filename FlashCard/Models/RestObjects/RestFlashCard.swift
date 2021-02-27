//
//  RestFlashCard.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import Foundation
import Firebase

struct RestFlashCard {
	let id: String
	let question: String
	let response: String
	let categoryID: String
	let boxNumber: Int
	let lastUpdateDate: Timestamp
}
