//
//  AEFontStyle.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

import SwiftUI

enum FontType: String {
    case gothamBold = "Gotham-Bold"
    case gothamMed = "Gotham-Medium"
    case gothamRndBold = "GothamRnd-Bold"
    case gothamRndMed = "GothamRnd-Medium"
}

struct AEFontStyle: ViewModifier {
    var size: CGFloat
    var fontType: FontType
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom(fontType.rawValue, size: size))
    }
}

extension View {
    func applyFontStyle(size: CGFloat, fontType: FontType) -> some View {
        modifier(AEFontStyle(size: size, fontType: fontType))
    }
}
