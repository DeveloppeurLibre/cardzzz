//
//  MainButton.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import SwiftUI

struct MainButton: View {
	
	let title: String
	let color: Color
	let onTap: () -> Void
	
    var body: some View {
		Button(action: onTap, label: {
			HStack {
				Spacer()
				Text(title)
					.font(.headline)
					.fontWeight(.semibold)
				Spacer()
			}
			.padding()
			.background(color)
			.foregroundColor(.white)
			.cornerRadius(10)
		})
    }
}

struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
		MainButton(title: "Test Button", color: .orange, onTap: {})
			.padding()
			.previewLayout(.sizeThatFits)
    }
}
