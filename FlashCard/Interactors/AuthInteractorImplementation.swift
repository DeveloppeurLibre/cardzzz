//
//  AuthInteractorImplementation.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import Foundation
import FirebaseAuth

protocol AuthInteractor {
	func signUp(withEmail email: String,
				password: String,
				completion: @escaping (AuthDataResult?, Error?) -> Void)
	func signIn(withEmail email: String,
				password: String,
				completion: @escaping (AuthDataResult?, Error?) -> Void)
}

class AuthInteractorImplementation: AuthInteractor {
	
	func signUp(withEmail email: String,
				password: String,
				completion: @escaping (AuthDataResult?, Error?) -> Void) {
		Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
			completion(authResult, error)
		}
	}
	
	func signIn(withEmail email: String,
				password: String,
				completion: @escaping (AuthDataResult?, Error?) -> Void) {
		Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
			guard let _ = self else { return }
			completion(authResult, error)
		}
	}
}
