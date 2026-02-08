//
//  RecommendedSection.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 08/02/2026.
//

import SwiftUI

struct RecommendedSection: View {
    let experiences: [Experience]
    var onHeartAction: ((Experience) async -> Void)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Recommended Experiences")
                .applyFontStyle(size: 22, fontType: .gothamBold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(experiences, id: \.id) { experience in
                        ExperienceCell(experience: experience, onHeartAction: onHeartAction)
                            .frame(width: 339, height: 180)
                    }
                }
                .padding(.horizontal, 16)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }
}
