//
//  View+ext.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

// Source - https://stackoverflow.com/a/64586227

import SwiftUI

extension View {
    func hideKeyboardWhenTappedAround() -> some View  {
        return self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                  to: nil, from: nil, for: nil)
        }
    }
}

