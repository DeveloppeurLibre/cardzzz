//
//  SessionScreen.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import SwiftUI

struct SessionScreen: View {
	
	let deck: Deck
	@State private var cardsToRecall = [FlashCard]()
	@State private var currentCard: FlashCard? = nil
	@State private var mode: Mode = .question
	@Environment(\.presentationMode) private var presentationMode
	@Environment(\.interactors) var interactors: InteractorsContainer
	
    var body: some View {
		VStack(spacing: 16) {
			Spacer()
			if let card = currentCard {
				Text(card.question)
					.font(.title2)
					.fontWeight(.semibold)
				if mode == .response {
					Divider()
					Text(card.response)
				}
			} else {
				Text("No card in this deck")
			}
			Spacer()
			makeFooter()
		}
		.padding()
		.onAppear(perform: {
			cardsToRecall = interactors.deckInteractor.getCardsToRecall(deck: deck)
			currentCard = cardsToRecall.popLast()
			if currentCard != nil {
				mode = .question
			} else {
				mode = .empty
			}
		})
    }
	
	@ViewBuilder private func makeFooter() -> some View {
		switch mode {
			case .question:
				MainButton(title: "Return", color: .blue, onTap: {
					mode = .response
				})
			case .response:
				HStack(spacing: 8) {
					FeedBackButton(title: "Wrong", color: .red, onTap: {
						reply(.wrong)
					})
					FeedBackButton(title: "Difficult", color: .orange, onTap: {
						reply(.difficult)
					})
					FeedBackButton(title: "Correct", color: .yellow, onTap: {
						reply(.correct)
					})
					FeedBackButton(title: "Easy", color: .green, onTap: {
						reply(.easy)
					})
				}
				.frame(height: 60)
			case .finished:
				MainButton(title: "Finish", color: .blue, onTap: {
					presentationMode.wrappedValue.dismiss()
				})
			case .empty:
				MainButton(title: "Come back later", color: .blue, onTap: {
					presentationMode.wrappedValue.dismiss()
				})
		}
	}
	
	private func reply(_ reply: Response) {
		guard let card = currentCard else { return }
		let feedback = Feedback(boxNumber: reply.rawValue, lastUpdateDate: Date())
		interactors.deckInteractor.update(feedback: feedback, for: card, in: deck)
		currentCard = cardsToRecall.popLast()
		if currentCard != nil {
			mode = .question
		} else {
			mode = .finished
		}
	}
	
	private enum Response: Int {
		case wrong = 1
		case difficult = 2
		case correct = 3
		case easy = 4
	}
	
	private enum Mode {
		case question
		case response
		case empty
		case finished
	}
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
		SessionScreen(deck: Deck.mockedData.first!)
    }
}
