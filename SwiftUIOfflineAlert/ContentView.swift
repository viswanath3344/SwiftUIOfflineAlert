//
//  ContentView.swift
//  SwiftUIOfflineAlert
//
//  Created by Ponthota, Viswanath Reddy on 07/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Welcome back !!!")
            Button("Click Me") {
                print("Button Press ")
            }
        }
        .offlineAlert()
    }
}

/// Allowing for any Generic NetworkMonitorService protocol implemented service.
struct OfflineModifier <T: NetworkMonitorService> : ViewModifier{
    @EnvironmentObject var networkMonitor: T
    func body(content: Content) -> some View {
        ZStack {
            content
            if !networkMonitor.hasNetworkConnection {
                ZStack {
                    HStack {
                        Image(systemName: "network.slash")
                        Text("No connection")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(.black.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .transition(.move(edge: .leading))
            }
        }
    }
}

extension View {
    func offlineAlert() -> some View {
        self.modifier(OfflineModifier<NetworkMonitor>())
    }
}

#Preview {
    ContentView()
}
