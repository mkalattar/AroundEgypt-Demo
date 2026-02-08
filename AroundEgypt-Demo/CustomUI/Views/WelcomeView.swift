//
//  HeaderView.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Welcome!")
                .applyFontStyle(size: 22, fontType: .gothamRndBold)
            
            Text("Now you can explore any experience in 360 degrees and get all the details about it all in one place.")
                .applyFontStyle(size: 14, fontType: .gothamRndMed)
        }
        .padding(21)
    }
}

#Preview {
    WelcomeView()
}
