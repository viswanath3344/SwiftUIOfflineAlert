//
//  SwiftUIOfflineAlertApp.swift
//  SwiftUIOfflineAlert
//
//  Created by Ponthota, Viswanath Reddy on 07/08/24.
//

import SwiftUI

@main
struct SwiftUIOfflineAlertApp: App {
    @StateObject var networkMonitor = AnotherNetworkMonitor()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(networkMonitor)
        }
    }
}
