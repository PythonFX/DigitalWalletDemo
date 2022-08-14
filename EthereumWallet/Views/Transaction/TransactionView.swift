//
//  TransactionView.swift
//  EthereumWallet
//
//  Created by ByteDance on 2022/8/13.
//

import SwiftUI

struct TransactionView: View {
    @EnvironmentObject var network: Network
    
    var body: some View {
        VStack {
            TransactionCurrencyView(currencies: $network.allCurrencies,
                                    convertToCurrencyType: $network.convertToCurrencyType)
            
            HStack {
                Button("Refresh") {
                    network.updateAllCurrencies()
                }
                .font(.title3)
                .padding(.init(top: 6, leading: 10, bottom: 6, trailing: 10))
                .foregroundColor(Color.blue)
                .overlay(
                    RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 2)
                )
                .padding()
                
                Button("Toggle") {
                    network.updateConvertToType()
                    network.resetAllCurrencies()
                    network.updateAllCurrencies()
                }
                .font(.title3)
                .padding(.init(top: 6, leading: 10, bottom: 6, trailing: 10))
                .foregroundColor(Color.blue)
                .overlay(
                    RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 2)
                )
                .padding()
            }
            
        }
        .onAppear {
            network.updateAllCurrencies()
        }
        
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView().environmentObject(Network())
    }
}
