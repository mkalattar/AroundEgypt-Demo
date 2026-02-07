//
//  AroundEgypt_DemoApp.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 06/02/2026.
//

import SwiftUI

@main
struct AroundEgypt_DemoApp: App {
    
    init() {
        let cache = URLCache(memoryCapacity: 50 * 1024 * 1024,
                             diskCapacity: 100 * 1024 * 1024)
        URLCache.shared = cache
    }
    
    var body: some Scene {
        WindowGroup {
        }
    }
}
