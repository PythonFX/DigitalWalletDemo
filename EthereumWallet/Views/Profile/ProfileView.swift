//
//  ProfileView.swift
//  EthereumWallet
//
//  Created by ByteDance on 2022/8/13.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var user: User
    
    @State private var showAvatarSheet = false
    @State private var showCurrencySheet = false
    @State private var selectedIndex: Int = 0
    
    let avatarNames: [String] = [
        "iron-man",
        "super-mario",
        "fursona",
        "futurama-amy-wong",
        "futurama-bender",
        "futurama-fry",
        "futurama-hermes-conrad",
        "futurama-leela",
        "futurama-zapp-brannigan",
    ]
    
    var body: some View {
        VStack {
            Text(user.name)
                .font(.title)
                .fontWeight(.bold)
                .padding(.init(top: 30, leading: 10, bottom: 0, trailing: 10))

            Image(avatarNames[selectedIndex])
                .frame(width: 64, height: 64, alignment: .center)
                .padding()
                .onTapGesture {
                    showAvatarSheet.toggle()
                }
            
            ProfileCurrencyView(ownedCurrencies: $user.ownedCurrencies)
            
        }.sheet(isPresented: $showAvatarSheet) {
            AvatarSheetView(selectedIndex: $selectedIndex, names: avatarNames)
        }.sheet(isPresented: $showCurrencySheet) {
            CurrencySheetView()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(User())
    }
}
