//
//  FlashCardCategory.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import SwiftUI
import Combine

class FlashCardCategory: Identifiable, ObservableObject {
	let id = UUID()
	@Published var name: String
	@Published var color: Color
	
	init(name: String, color: Color) {
		self.name = name
		self.color = color
	}
}
