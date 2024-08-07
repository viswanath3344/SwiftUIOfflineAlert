//
//  NetworkMonitor.swift
//  SwiftUIOfflineAlert
//
//  Created by Ponthota, Viswanath Reddy (Cognizant) on 07/08/24.
//

import Foundation
import Network
import SwiftUI

class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    
    /// States whether network connection available.
    @Published var hasNetworkConnection = true
    
    init() {
        networkMonitor.pathUpdateHandler = { [weak self] path in
            guard let self else { return }
            print(path.status)
            self.setNetworkConnection(path.status == .satisfied)
        }
        
        networkMonitor.start(queue: DispatchQueue.global())
    }
    
    private func setNetworkConnection(_ isConnected: Bool) {
        Task { @MainActor in
            withAnimation {
                hasNetworkConnection = isConnected
            }
        }
    }
}
