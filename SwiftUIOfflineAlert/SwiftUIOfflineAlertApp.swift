//
//  SwiftUIOfflineAlertApp.swift
//  SwiftUIOfflineAlert
//
//  Created by Ponthota, Viswanath Reddy (Cognizant) on 07/08/24.
//

import SwiftUI

@main
struct SwiftUIOfflineAlertApp: App {
    @ObservedObject var networkMonitor = NetworkMonitor()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(networkMonitor)
        }
    }
}
