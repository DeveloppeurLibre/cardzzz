//
//  FloatingButton.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import SwiftUI

struct FloatingButton: View {
	
	let iconName: String
	let color: Color
	let onTap: () -> Void
	
    var body: some View {
		Button(action: onTap, label: {
			ZStack {
				Circle()
					.frame(width: 80, height: 80)
					.foregroundColor(color)
					.shadow(radius: 10)
				Image(systemName: iconName)
					.foregroundColor(.white)
					.font(.system(size: 30, weight: .bold))
			}
		})
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
		FloatingButton(iconName: "plus", color: .blue, onTap: {})
			.padding()
			.previewLayout(.sizeThatFits)
    }
}
