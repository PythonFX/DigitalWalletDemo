//
//  ContentView.swift
//  EthereumWallet
//
//  Created by ByteDance on 2022/8/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MarketView()
                .tabItem {
                    Label("Market", systemImage: "bitcoinsign.circle")
                }

            TransactionView()
                .tabItem {
                    Label("Transaction", systemImage: "suitcase.cart.fill")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(User())
    }
}
