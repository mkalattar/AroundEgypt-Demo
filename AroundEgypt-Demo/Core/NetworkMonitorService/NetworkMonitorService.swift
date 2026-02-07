//
//  NetworkMonitorService.swift
//  AroundEgypt-Demo
//
//  Created by Mohamed K Attar on 07/02/2026.
//

import Foundation
import Network
import Observation

protocol NetworkMonitorProtocol: Sendable {
    var isConnected: Bool { get }
}

@Observable
final class NetworkMonitorService: NetworkMonitorProtocol {
 
    static let shared = NetworkMonitorService()
    
    private(set) var isConnected: Bool = true
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    private init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            
            Task { @MainActor in
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}
