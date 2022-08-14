//
//  EthereumWalletApp.swift
//  EthereumWallet
//
//  Created by ByteDance on 2022/8/13.
//

import SwiftUI

@main
struct EthereumWalletApp: App {
    var network = Network()
    var user = User()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
                .environmentObject(user)
        }
    }
}
