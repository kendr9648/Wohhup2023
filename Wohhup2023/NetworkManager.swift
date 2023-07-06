//
//  NetworkManager.swift
//  Wohhup2023
//
//  Created by William Kendrick on 6/7/23.
//

import Foundation
import Network

class NetworkManager {
    static let shared = NetworkManager()
    private let monitor = NWPathMonitor()

    private init() {
        monitor.pathUpdateHandler = { path in
            // Handle network path update here
            self.handleNetworkPath(path)
        }
        let queue = DispatchQueue(label: "NetworkMonitorQueue")
        monitor.start(queue: queue)
    }

    private func handleNetworkPath(_ path: NWPath) {
        if path.status == .satisfied {
            // Network is reachable
        } else {
            // Network is not reachable
        }
    }
}


