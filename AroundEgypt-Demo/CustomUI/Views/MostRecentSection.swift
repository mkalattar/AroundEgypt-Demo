//
//  MostRecentSection.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 08/02/2026.
//
import SwiftUI

struct MostRecentSection: View {
    
    var recentExperiences: [Experience]
    var onHeartAction: (Experience) async -> Void
    
    var body: some View {
        
        LazyVStack(alignment: .leading) {
            Text("Most Recent")
                .applyFontStyle(size: 22, fontType: .gothamBold)
            
            ForEach(recentExperiences, id: \.id) { experience in
                ExperienceCell(experience: experience, onHeartAction: onHeartAction)
                    .frame(height: 200)
            }
        }
        .padding(21)
    }
}
