//
//  LoginScreen.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import SwiftUI

struct LoginScreen: View {
	
	@State private var email = ""
	@State private var password = ""
	@State private var mode: Mode = .login
	@State private var errorMessage: String = ""
	@State private var isShowingHomeScreen = false
	@Environment(\.interactors) var interactors: InteractorsContainer
	
    var body: some View {
		NavigationView {
			VStack(spacing: 32) {
				Text("Welcome !")
					.font(.title)
					.fontWeight(.semibold)
				Text(getDesctiption())
					.multilineTextAlignment(.center)
					.foregroundColor(.gray)
					.font(.callout)
				VStack {
					TextField("Enter your email", text: $email)
						.keyboardType(.emailAddress)
					SecureField("Password", text: $password)
						.keyboardType(.default)
				}
				.textFieldStyle(RoundedBorderTextFieldStyle())
				if !errorMessage.isEmpty {
					Text(errorMessage)
						.foregroundColor(.red)
				}
				NavigationLink(
					destination: HomeScreen().navigationBarHidden(true),
					isActive: $isShowingHomeScreen,
					label: {
						MainButton(title: getButtonTitle(), color: .blue) {
							switch mode {
								case .login:
									interactors.authInteractor.signIn(withEmail: email, password: password) { (userData, error) in
										if let error = error {
											errorMessage = error.localizedDescription
										}
										if let _ = userData {
											isShowingHomeScreen.toggle()
										}
									}
								case .signup:
									interactors.authInteractor.signUp(withEmail: email, password: password) { (userData, error) in
										if let error = error {
											errorMessage = error.localizedDescription
										}
										if let _ = userData {
											isShowingHomeScreen.toggle()
										}
									}
							}
						}
					})
				Button(action: {
					mode.toggle()
				}, label: {
					Text(getDetailButtonTitle())
				})
			}
			.padding()
			.navigationBarHidden(true)
		}
    }
	
	private func getButtonTitle() -> String {
		switch mode {
			case .login:
				return "Login"
			case .signup:
				return "Sign up"
		}
	}
	
	private func getDetailButtonTitle() -> String {
		switch mode {
			case .login:
				return "Create an account"
			case .signup:
				return "Already have an account ?"
		}
	}
	
	private func getDesctiption() -> String {
		switch mode {
			case .login:
				return "Please login to your account to\nrecover all your flash cards"
			case .signup:
				return "You can create an account to start\nlearning with flash cards"
		}
	}
	
	private enum Mode {
		case login
		case signup
		
		mutating func toggle() {
			switch self {
				case .login:
					self = .signup
				case .signup:
					self = .login
			}
		}
	}
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
