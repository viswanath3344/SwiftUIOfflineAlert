//
//  NetworkMonitor.swift
//  SwiftUIOfflineAlert
//
//  Created by Ponthota, Viswanath Reddy on 07/08/24.
//

import Foundation
import Network
import SwiftUI

/// Decouple the Network availability  from concrete implementation for future purpose
///  if the we want to change another network service(e.g Alamafire, other reachability checks...).
protocol NetworkMonitorService: ObservableObject  {
  var hasNetworkConnection: Bool { get }
}

class NetworkMonitor: NetworkMonitorService {
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


/// Mocking Network monitor
class AnotherNetworkMonitor: NetworkMonitorService {
    @Published var hasNetworkConnection: Bool = true
    
    init() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self else { return }
            self.setNetworkConnection(false)
        }
    }
    
    private func setNetworkConnection(_ isConnected: Bool) {
        Task { @MainActor in
            withAnimation {
                hasNetworkConnection = isConnected
            }
        }
    }
}
