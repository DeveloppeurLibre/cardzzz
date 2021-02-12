//
//  FeedBackButton.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import SwiftUI

struct FeedBackButton: View {
	
	let title: String
	let color: Color
	let onTap: () -> Void
	
    var body: some View {
		Button(action: onTap, label: {
			HStack {
				Spacer()
				Text(title)
					.font(.callout)
					.fontWeight(.bold)
					.foregroundColor(.white)
					.padding(.vertical)
				Spacer()
			}
			.background(color.opacity(0.8))
		})
    }
}

struct FeedBackButton_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			FeedBackButton(title: "Wrong", color: .red, onTap: {})
			FeedBackButton(title: "Difficult", color: .orange, onTap: {})
			FeedBackButton(title: "Correct", color: .yellow, onTap: {})
			FeedBackButton(title: "Easy", color: .green, onTap: {})
		}
		.previewLayout(.sizeThatFits)
    }
}
