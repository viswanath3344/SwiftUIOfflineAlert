//
//  ContentView.swift
//  SwiftUIOfflineAlert
//
//  Created by Ponthota, Viswanath Reddy (Cognizant) on 07/08/24.
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
        //.modifier(offlineModifier())network.slash
    }
}


struct offlineModifier : ViewModifier {
    @EnvironmentObject var networkMonitor: NetworkMonitor
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
        self.modifier(offlineModifier())
    }
}

#Preview {
    ContentView()
}
