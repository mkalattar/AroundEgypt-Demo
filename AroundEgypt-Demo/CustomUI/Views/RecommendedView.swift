//
//  RecommendedView.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

import SwiftUI

struct RecommendedView: View {
    var body: some View {
        HStack(spacing: 4) {
            Image(.starIcn)
                .resizable()
                .frame(width: 10, height: 10)
            
            Text("RECOMMENDED")
                .foregroundStyle(Color.white)
                .applyFontStyle(size: 10, fontType: .gothamBold)
        }
        .padding(6)
        .background {
            Capsule()
                .foregroundStyle(Color.black.opacity(0.5))
        }
    }
}

#Preview {
    RecommendedView()
}
