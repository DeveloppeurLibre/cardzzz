//
//  FirebaseUsersRepository.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import Foundation
import FirebaseFirestore

struct FirebaseUsersRepository: UserRepository {
	let database = Firestore.firestore()
}
