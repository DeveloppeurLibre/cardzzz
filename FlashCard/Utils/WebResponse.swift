//
//  WebResponse.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import Foundation

enum WebResponse<T> {
	case success(response: T)
	case failure(error: Error)
}
