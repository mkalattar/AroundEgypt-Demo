//
//  MockNetworkMonitorService.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

import Foundation
@testable import AroundEgypt_Demo

final class MockNetworkMonitorService: NetworkMonitorProtocol {
    var isConnected: Bool = true
    
    func enableConnection() {
        self.isConnected = true
    }
    
    func disableConnection() {
        self.isConnected = false
    }
}
