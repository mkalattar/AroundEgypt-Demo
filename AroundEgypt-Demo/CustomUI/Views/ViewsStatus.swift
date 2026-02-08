//
//  ViewsStatus.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

import SwiftUI

struct ViewsStatus: View {
    var viewsNumber: Int = 0
    
    var body: some View {
        HStack {
            Image(.eye)
                .resizable()
                .frame(width: 14, height: 10)
            
            Text("\(viewsNumber)")
                .applyFontStyle(size: 14, fontType: .gothamMed)
                .foregroundStyle(Color.white)
        }
    }
}
