//
//  HeadedTextEditor.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import SwiftUI

struct HeadedTextEditor: View {
	
	let header: String
	@Binding var text: String
	
    var body: some View {
		VStack(alignment: .leading, spacing: 0) {
			Text(header)
				.foregroundColor(.gray)
				.font(.callout)
			TextEditor(text: $text)
		}
		.padding(8)
		.overlay(
			RoundedRectangle(cornerRadius: 5)
				.stroke(Color.gray, lineWidth: 0.5)
		)
    }
}

struct HeadedTextEditor_Previews: PreviewProvider {
	
	@State static var text = ""
	
    static var previews: some View {
		HeadedTextEditor(header: "Test Header", text: $text)
			.padding()
			.previewLayout(.sizeThatFits)
    }
}
