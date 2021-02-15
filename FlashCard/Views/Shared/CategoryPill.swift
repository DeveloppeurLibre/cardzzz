//
//  CategoryPill.swift
//  FlashCard
//
//  Created by Quentin Cornu on 12/02/2021.
//

import SwiftUI

struct CategoryPill: View {
	
	let category: FlashCardCategory
	let format: Format
		
    var body: some View {
		Text(category.name)
			.font(.system(size: getFontSize()))
			.foregroundColor(.white)
			.padding(.vertical, 4)
			.padding(.horizontal, 12)
			.background(Rectangle().foregroundColor(category.color))
			.clipShape(RoundedRectangle(cornerRadius: 25))
    }
	
	private func getFontSize() -> CGFloat {
		switch format {
			case .caption:
				return 12
			case .selectable:
				return 16
		}
	}
	
	enum Format {
		case caption
		case selectable
	}
}

struct FlashCardCategoryPill_Previews: PreviewProvider {
	
	static let category = FlashCardCategory(name: "Test", color: .orange)
	@State static var isSelected = false
	
    static var previews: some View {
		Group {
			CategoryPill(category: category, format: .caption)
			CategoryPill(category: category, format: .selectable)
		}
		.padding()
		.previewLayout(.sizeThatFits)
    }
}
